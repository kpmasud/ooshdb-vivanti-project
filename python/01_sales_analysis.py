"""
=============================================================================
PROJECT  : Ooshman Food Business — PostgreSQL Analysis
FILE     : python/01_sales_analysis.py
PURPOSE  : Revenue trends, shop performance, payment methods, order values
           Mirrors: sql/01_sales_analysis.sql
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

SHOP_COLOURS = {
    "Ooshman Greenway":  "#2ecc71",
    "Ooshman Weston":    "#3498db",
    "Ooshman Gungahlin": "#e74c3c",
}


def query(sql):
    with psycopg2.connect(**PG) as conn:
        return pd.read_sql(sql, conn)


def save(fig, name):
    path = os.path.join(OUTPUT_DIR, name)
    fig.savefig(path, bbox_inches="tight", dpi=150)
    plt.close(fig)
    print(f"  Saved: outputs/{name}")


# ── Q1 : Revenue by shop ──────────────────────────────────────────────────
def plot_revenue_by_shop():
    df = query("""
        SELECT s.name AS shop_name,
               COUNT(o.order_id) AS total_orders,
               ROUND(SUM(o.order_value)::NUMERIC, 2) AS total_revenue,
               ROUND(AVG(o.order_value)::NUMERIC, 2) AS avg_order_value
        FROM orders o JOIN shops s ON o.shop_id = s.shop_id
        GROUP BY s.shop_id, s.name ORDER BY total_revenue DESC
    """)

    fig, axes = plt.subplots(1, 2, figsize=(13, 5))
    fig.suptitle("Shop Revenue Overview", fontweight="bold", fontsize=13)

    colors = [SHOP_COLOURS.get(n, "steelblue") for n in df["shop_name"]]
    bars = axes[0].bar(df["shop_name"], df["total_revenue"] / 1e6, color=colors)
    for bar, val in zip(bars, df["total_revenue"]):
        axes[0].text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.02,
                     f"${val/1e6:.1f}M", ha="center", va="bottom", fontsize=10, fontweight="bold")
    axes[0].set_title("Total Revenue by Shop")
    axes[0].set_ylabel("Revenue ($M)")
    axes[0].tick_params(axis="x", rotation=10)

    bars2 = axes[1].bar(df["shop_name"], df["avg_order_value"], color=colors)
    for bar, val in zip(bars2, df["avg_order_value"]):
        axes[1].text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.2,
                     f"${val:.2f}", ha="center", va="bottom", fontsize=10, fontweight="bold")
    axes[1].set_title("Average Order Value by Shop")
    axes[1].set_ylabel("Avg Order Value ($)")
    axes[1].tick_params(axis="x", rotation=10)

    plt.tight_layout()
    save(fig, "01a_revenue_by_shop.png")


# ── Q2 : Monthly revenue trend ────────────────────────────────────────────
def plot_monthly_revenue():
    df = query("""
        SELECT DATE_TRUNC('month', order_datetime)::DATE AS month,
               ROUND(SUM(order_value)::NUMERIC, 2) AS total_revenue,
               COUNT(*) AS total_orders
        FROM orders GROUP BY month ORDER BY month
    """)
    df["month"] = pd.to_datetime(df["month"])

    fig, ax1 = plt.subplots(figsize=(14, 5))
    ax2 = ax1.twinx()
    ax1.fill_between(df["month"], df["total_revenue"] / 1e3, alpha=0.2, color="steelblue")
    ax1.plot(df["month"], df["total_revenue"] / 1e3, "o-", color="steelblue",
             linewidth=2, markersize=5, label="Revenue ($K)")
    ax2.plot(df["month"], df["total_orders"], "s--", color="coral",
             linewidth=1.5, markersize=4, label="Orders")
    ax1.set_title("Monthly Revenue & Order Volume Trend", fontweight="bold")
    ax1.set_xlabel("")
    ax1.set_ylabel("Revenue ($K)")
    ax2.set_ylabel("Total Orders")
    lines1, labels1 = ax1.get_legend_handles_labels()
    lines2, labels2 = ax2.get_legend_handles_labels()
    ax1.legend(lines1 + lines2, labels1 + labels2, loc="upper left")
    plt.tight_layout()
    save(fig, "01b_monthly_revenue_trend.png")


# ── Q3 : Payment method breakdown ─────────────────────────────────────────
def plot_payment_methods():
    df = query("""
        SELECT pm.payment_method_name,
               COUNT(o.order_id) AS total_orders,
               ROUND(SUM(o.order_value)::NUMERIC, 2) AS total_revenue,
               ROUND(COUNT(o.order_id) * 100.0 / SUM(COUNT(o.order_id)) OVER (), 1) AS order_pct
        FROM orders o JOIN payment_methods pm ON o.payment_id = pm.payment_id
        GROUP BY pm.payment_method_name ORDER BY total_orders DESC
    """)

    fig, axes = plt.subplots(1, 2, figsize=(13, 5))
    fig.suptitle("Payment Method Analysis", fontweight="bold", fontsize=13)
    palette = sns.color_palette("Set2", len(df))

    axes[0].pie(df["total_orders"], labels=df["payment_method_name"],
                autopct="%1.1f%%", startangle=140, colors=palette)
    axes[0].set_title("Order Share by Payment Method")

    bars = axes[1].bar(df["payment_method_name"], df["total_revenue"] / 1e6, color=palette)
    for bar, val in zip(bars, df["total_revenue"]):
        axes[1].text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.02,
                     f"${val/1e6:.1f}M", ha="center", va="bottom", fontsize=9)
    axes[1].set_title("Revenue by Payment Method")
    axes[1].set_ylabel("Revenue ($M)")
    axes[1].tick_params(axis="x", rotation=10)

    plt.tight_layout()
    save(fig, "01c_payment_methods.png")


# ── Q4 : Order value distribution ────────────────────────────────────────
def plot_order_value_distribution():
    df = query("""
        SELECT CASE
            WHEN order_value < 20          THEN 'Under $20'
            WHEN order_value BETWEEN 20 AND 39.99 THEN '$20-$39'
            WHEN order_value BETWEEN 40 AND 59.99 THEN '$40-$59'
            WHEN order_value BETWEEN 60 AND 99.99 THEN '$60-$99'
            ELSE '$100+'
        END AS value_band,
        COUNT(*) AS orders,
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
        FROM orders GROUP BY value_band ORDER BY MIN(order_value)
    """)

    fig, ax = plt.subplots(figsize=(10, 5))
    colors = sns.color_palette("RdYlGn", len(df))
    bars = ax.bar(df["value_band"], df["orders"], color=colors)
    for bar, pct, cnt in zip(bars, df["pct"], df["orders"]):
        ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 500,
                f"{pct}%\n({cnt:,})", ha="center", va="bottom", fontsize=9)
    ax.set_title("Order Value Distribution", fontweight="bold")
    ax.set_xlabel("Order Value Band")
    ax.set_ylabel("Number of Orders")
    ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    save(fig, "01d_order_value_distribution.png")


# ── Q5 : Monthly revenue by shop ─────────────────────────────────────────
def plot_monthly_revenue_by_shop():
    df = query("""
        SELECT DATE_TRUNC('month', o.order_datetime)::DATE AS month,
               s.name AS shop_name,
               ROUND(SUM(o.order_value)::NUMERIC, 2) AS revenue
        FROM orders o JOIN shops s ON o.shop_id = s.shop_id
        GROUP BY month, s.name ORDER BY month, s.name
    """)
    df["month"] = pd.to_datetime(df["month"])

    fig, ax = plt.subplots(figsize=(14, 5))
    for shop, grp in df.groupby("shop_name"):
        ax.plot(grp["month"], grp["revenue"] / 1e3, linewidth=2,
                label=shop, color=SHOP_COLOURS.get(shop), marker="o", markersize=3)
    ax.set_title("Monthly Revenue by Shop", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Revenue ($K)")
    ax.legend(title="Shop")
    plt.tight_layout()
    save(fig, "01e_monthly_revenue_by_shop.png")


# ── Q6 : Quarterly revenue by shop ───────────────────────────────────────
def plot_quarterly_revenue():
    df = query("""
        SELECT EXTRACT(YEAR FROM o.order_datetime)::INT  AS year,
               EXTRACT(QUARTER FROM o.order_datetime)::INT AS quarter,
               s.name AS shop_name,
               ROUND(SUM(o.order_value)::NUMERIC, 2) AS revenue
        FROM orders o JOIN shops s ON o.shop_id = s.shop_id
        GROUP BY year, quarter, s.name
        ORDER BY year, quarter, s.name
    """)
    df["period"] = df["year"].astype(str) + " Q" + df["quarter"].astype(str)

    pivot = df.pivot_table(index="period", columns="shop_name",
                           values="revenue", aggfunc="sum").fillna(0)

    fig, ax = plt.subplots(figsize=(14, 5))
    colors = [SHOP_COLOURS.get(c, "steelblue") for c in pivot.columns]
    pivot.plot(kind="bar", ax=ax, color=colors, width=0.7)
    ax.set_title("Quarterly Revenue by Shop", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Revenue ($)")
    ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("${x:,.0f}"))
    ax.tick_params(axis="x", rotation=30)
    ax.legend(title="Shop")
    plt.tight_layout()
    save(fig, "01f_quarterly_revenue.png")


# ── Main ───────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    print("=" * 60)
    print("  Ooshman — Sales Analysis")
    print("=" * 60)
    plot_revenue_by_shop()
    plot_monthly_revenue()
    plot_payment_methods()
    plot_order_value_distribution()
    plot_monthly_revenue_by_shop()
    plot_quarterly_revenue()
    print("\nSales analysis complete.")
