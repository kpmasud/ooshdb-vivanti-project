"""
=============================================================================
PROJECT  : Ooshman Food Business — PostgreSQL Analysis
FILE     : python/04_operations_analysis.py
PURPOSE  : Peak hours, day of week, delivery trends, year-over-year
           Mirrors: sql/04_operations_analysis.sql
=============================================================================
"""

import os
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import seaborn as sns
import psycopg2
from dotenv import load_dotenv

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
load_dotenv(os.path.join(BASE_DIR, ".env"))

PG = dict(
    host     = os.getenv("PG_HOST", "localhost"),
    port     = int(os.getenv("PG_PORT", 5432)),
    user     = os.getenv("PG_USER", "postgres"),
    password = os.getenv("PG_PASSWORD", ""),
    dbname   = os.getenv("PG_DATABASE", "ooshdb"),
)
OUTPUT_DIR = os.path.join(BASE_DIR, "outputs")
os.makedirs(OUTPUT_DIR, exist_ok=True)

sns.set_theme(style="whitegrid", palette="muted", font_scale=1.05)


def query(sql):
    with psycopg2.connect(**PG) as conn:
        return pd.read_sql(sql, conn)


def save(fig, name):
    path = os.path.join(OUTPUT_DIR, name)
    fig.savefig(path, bbox_inches="tight", dpi=150)
    plt.close(fig)
    print(f"  Saved: outputs/{name}")


# ── Q1 : Orders by hour of day ────────────────────────────────────────────
def plot_orders_by_hour():
    df = query("""
        SELECT EXTRACT(HOUR FROM order_datetime)::INT AS hour,
               COUNT(*) AS total_orders,
               ROUND(AVG(order_value)::NUMERIC, 2) AS avg_order_value
        FROM orders GROUP BY hour ORDER BY hour
    """)

    fig, ax1 = plt.subplots(figsize=(13, 5))
    ax2 = ax1.twinx()
    colors = ["#e74c3c" if o == df["total_orders"].max() else "steelblue"
              for o in df["total_orders"]]
    ax1.bar(df["hour"], df["total_orders"], color=colors, alpha=0.8, label="Orders")
    ax2.plot(df["hour"], df["avg_order_value"], "o-", color="coral",
             linewidth=2, markersize=6, label="Avg Order Value ($)")
    ax1.set_title("Orders & Average Spend by Hour of Day", fontweight="bold")
    ax1.set_xlabel("Hour of Day")
    ax1.set_ylabel("Total Orders")
    ax2.set_ylabel("Avg Order Value ($)")
    ax1.set_xticks(range(0, 24))
    ax1.yaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    lines1, labels1 = ax1.get_legend_handles_labels()
    lines2, labels2 = ax2.get_legend_handles_labels()
    ax1.legend(lines1 + lines2, labels1 + labels2, loc="upper left")
    plt.tight_layout()
    save(fig, "04a_orders_by_hour.png")


# ── Q2 : Orders by day of week ────────────────────────────────────────────
def plot_orders_by_day():
    df = query("""
        SELECT TO_CHAR(order_datetime, 'Day') AS day_name,
               EXTRACT(DOW FROM order_datetime)::INT AS day_num,
               COUNT(*) AS total_orders,
               ROUND(SUM(order_value)::NUMERIC, 2) AS total_revenue
        FROM orders GROUP BY day_name, day_num ORDER BY day_num
    """)
    df["day_name"] = df["day_name"].str.strip()

    fig, ax = plt.subplots(figsize=(10, 5))
    colors = ["#e74c3c" if o == df["total_orders"].max() else "steelblue"
              for o in df["total_orders"]]
    bars = ax.bar(df["day_name"], df["total_orders"], color=colors)
    for bar, val in zip(bars, df["total_orders"]):
        ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 200,
                f"{val:,}", ha="center", va="bottom", fontsize=9)
    ax.set_title("Total Orders by Day of Week", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Total Orders")
    ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    save(fig, "04b_orders_by_day.png")


# ── Q3 : Year-over-year comparison ────────────────────────────────────────
def plot_yoy_comparison():
    df = query("""
        SELECT EXTRACT(YEAR FROM order_datetime)::INT AS year,
               EXTRACT(MONTH FROM order_datetime)::INT AS month,
               COUNT(*) AS total_orders,
               ROUND(SUM(order_value)::NUMERIC, 2) AS total_revenue
        FROM orders WHERE EXTRACT(YEAR FROM order_datetime) IN (2023, 2024)
        GROUP BY year, month ORDER BY year, month
    """)

    fig, axes = plt.subplots(1, 2, figsize=(14, 5))
    fig.suptitle("2023 vs 2024 — Year-over-Year Comparison", fontweight="bold", fontsize=13)

    for year, grp in df.groupby("year"):
        axes[0].plot(grp["month"], grp["total_orders"], "o-", linewidth=2,
                     markersize=6, label=str(year))
        axes[1].plot(grp["month"], grp["total_revenue"] / 1e3, "o-", linewidth=2,
                     markersize=6, label=str(year))

    for ax, ylabel, title in zip(axes,
                                  ["Total Orders", "Revenue ($K)"],
                                  ["Monthly Orders: 2023 vs 2024", "Monthly Revenue: 2023 vs 2024"]):
        ax.set_title(title, fontweight="bold")
        ax.set_xlabel("Month")
        ax.set_ylabel(ylabel)
        ax.xaxis.set_major_locator(mticker.MultipleLocator(1))
        ax.legend(title="Year")

    plt.tight_layout()
    save(fig, "04c_yoy_comparison.png")


# ── Q4 : Monthly order value distribution (percentiles) ──────────────────
def plot_monthly_order_value_trend():
    df = query("""
        SELECT DATE_TRUNC('month', order_datetime)::DATE AS month,
               PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY order_value) AS p25,
               PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY order_value) AS p50,
               PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY order_value) AS p75,
               ROUND(AVG(order_value)::NUMERIC, 2) AS avg_value
        FROM orders GROUP BY month ORDER BY month
    """)
    df["month"] = pd.to_datetime(df["month"])

    fig, ax = plt.subplots(figsize=(14, 5))
    ax.fill_between(df["month"], df["p25"], df["p75"], alpha=0.15,
                    color="steelblue", label="25th–75th percentile")
    ax.plot(df["month"], df["p50"], "o-", color="steelblue",
            linewidth=2, markersize=4, label="Median order value")
    ax.plot(df["month"], df["avg_value"], "s--", color="coral",
            linewidth=1.5, markersize=4, label="Avg order value")
    ax.set_title("Monthly Order Value Distribution (Median, Avg & IQR)", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Order Value ($)")
    ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("${x:,.0f}"))
    ax.legend()
    plt.tight_layout()
    save(fig, "04d_monthly_order_value_trend.png")


# ── Q5 : Busiest weeks ────────────────────────────────────────────────────
def plot_busiest_weeks():
    df = query("""
        SELECT DATE_TRUNC('week', order_datetime)::DATE AS week_start,
               COUNT(*) AS total_orders,
               ROUND(SUM(order_value)::NUMERIC, 2) AS total_revenue
        FROM orders GROUP BY week_start ORDER BY total_orders DESC LIMIT 20
    """)
    df["week_label"] = pd.to_datetime(df["week_start"]).dt.strftime("%b %d %Y")

    fig, ax = plt.subplots(figsize=(13, 5))
    colors = sns.color_palette("YlOrRd_r", len(df))
    ax.barh(df["week_label"][::-1], df["total_orders"][::-1], color=colors)
    ax.set_title("Top 20 Busiest Weeks by Order Volume", fontweight="bold")
    ax.set_xlabel("Total Orders")
    ax.xaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    plt.tight_layout()
    save(fig, "04e_busiest_weeks.png")


# ── Q6 : Hour × day heatmap ───────────────────────────────────────────────
def plot_hour_day_heatmap():
    df = query("""
        SELECT EXTRACT(DOW FROM order_datetime)::INT AS day_num,
               TO_CHAR(order_datetime, 'Dy') AS day_name,
               EXTRACT(HOUR FROM order_datetime)::INT AS hour,
               COUNT(*) AS orders
        FROM orders GROUP BY day_num, day_name, hour ORDER BY day_num, hour
    """)
    df["day_name"] = df["day_name"].str.strip()
    pivot = df.pivot_table(index="day_name", columns="hour", values="orders", aggfunc="sum").fillna(0)
    day_order = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    pivot = pivot.reindex([d for d in day_order if d in pivot.index])

    fig, ax = plt.subplots(figsize=(16, 5))
    sns.heatmap(pivot, cmap="YlOrRd", ax=ax, linewidths=0.3,
                cbar_kws={"label": "Orders"},
                fmt=".0f", annot=False)
    ax.set_title("Order Volume Heatmap — Hour of Day × Day of Week", fontweight="bold")
    ax.set_xlabel("Hour of Day")
    ax.set_ylabel("")
    plt.tight_layout()
    save(fig, "04f_hour_day_heatmap.png")


# ── Main ───────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    print("=" * 60)
    print("  Ooshman — Operations Analysis")
    print("=" * 60)
    plot_orders_by_hour()
    plot_orders_by_day()
    plot_yoy_comparison()
    plot_monthly_order_value_trend()
    plot_busiest_weeks()
    plot_hour_day_heatmap()
    print("\nOperations analysis complete.")
