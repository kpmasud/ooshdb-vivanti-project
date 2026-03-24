"""
=============================================================================
PROJECT  : Ooshman Food Business — PostgreSQL Analysis
FILE     : python/02_customer_analysis.py
PURPOSE  : Customer demographics, order frequency, and spending patterns
           Mirrors: sql/02_customer_analysis.sql
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


# ── Q1 : Age group distribution ───────────────────────────────────────────
def plot_age_distribution():
    df = query("""
        SELECT CASE
            WHEN DATE_PART('year', AGE(date_of_birth)) < 18  THEN 'Under 18'
            WHEN DATE_PART('year', AGE(date_of_birth)) < 25  THEN '18-24'
            WHEN DATE_PART('year', AGE(date_of_birth)) < 35  THEN '25-34'
            WHEN DATE_PART('year', AGE(date_of_birth)) < 45  THEN '35-44'
            WHEN DATE_PART('year', AGE(date_of_birth)) < 60  THEN '45-59'
            ELSE '60+'
        END AS age_group,
        COUNT(*) AS customers,
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
        FROM customers WHERE date_of_birth IS NOT NULL
        GROUP BY age_group ORDER BY MIN(DATE_PART('year', AGE(date_of_birth)))
    """)

    fig, ax = plt.subplots(figsize=(10, 5))
    colors = sns.color_palette("Blues_d", len(df))
    bars = ax.bar(df["age_group"], df["customers"], color=colors)
    for bar, pct in zip(bars, df["pct"]):
        ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 500,
                f"{pct}%", ha="center", va="bottom", fontsize=10, fontweight="bold")
    ax.set_title("Customer Age Group Distribution", fontweight="bold")
    ax.set_xlabel("Age Group")
    ax.set_ylabel("Number of Customers")
    ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    save(fig, "02a_age_distribution.png")


# ── Q2 : Order frequency ─────────────────────────────────────────────────
def plot_order_frequency():
    df = query("""
        WITH order_counts AS (
            SELECT customer_id, COUNT(*) AS order_count FROM orders GROUP BY customer_id
        )
        SELECT CASE
            WHEN order_count = 1  THEN '1 order'
            WHEN order_count <= 3 THEN '2-3 orders'
            WHEN order_count <= 5 THEN '4-5 orders'
            WHEN order_count <= 10 THEN '6-10 orders'
            ELSE '10+ orders'
        END AS frequency_band,
        COUNT(*) AS customers,
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
        FROM order_counts GROUP BY frequency_band ORDER BY MIN(order_count)
    """)

    fig, axes = plt.subplots(1, 2, figsize=(13, 5))
    fig.suptitle("Customer Order Frequency", fontweight="bold", fontsize=13)
    palette = sns.color_palette("Set2", len(df))

    axes[0].pie(df["customers"], labels=df["frequency_band"],
                autopct="%1.1f%%", startangle=140, colors=palette)
    axes[0].set_title("Customer Share by Order Frequency")

    bars = axes[1].bar(df["frequency_band"], df["customers"], color=palette)
    for bar, cnt in zip(bars, df["customers"]):
        axes[1].text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 500,
                     f"{cnt:,}", ha="center", va="bottom", fontsize=9)
    axes[1].set_title("Customer Count by Order Frequency")
    axes[1].set_ylabel("Customers")
    axes[1].yaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    axes[1].tick_params(axis="x", rotation=10)

    plt.tight_layout()
    save(fig, "02b_order_frequency.png")


# ── Q3 : Gender split by shop ─────────────────────────────────────────────
def plot_gender_by_shop():
    df = query("""
        SELECT s.name AS shop_name, c.gender,
               COUNT(DISTINCT o.customer_id) AS customers
        FROM orders o
        JOIN customers c ON o.customer_id = c.customer_id
        JOIN shops s ON o.shop_id = s.shop_id
        GROUP BY s.name, c.gender ORDER BY s.name, c.gender
    """)
    pivot = df.pivot(index="shop_name", columns="gender", values="customers").fillna(0)

    fig, ax = plt.subplots(figsize=(10, 5))
    pivot.plot(kind="bar", ax=ax, color=["#e91e8c", "#2196f3"], width=0.5)
    ax.set_title("Customer Gender Split by Shop", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Unique Customers")
    ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    ax.tick_params(axis="x", rotation=10)
    ax.legend(title="Gender")
    for container in ax.containers:
        ax.bar_label(container, fmt="{:,.0f}", padding=2, fontsize=9)
    plt.tight_layout()
    save(fig, "02c_gender_by_shop.png")


# ── Q4 : Top 10 highest-spending customers ────────────────────────────────
def plot_top_customers():
    df = query("""
        SELECT o.customer_id,
               c.first_name || ' ' || c.last_name AS customer_name,
               COUNT(o.order_id) AS total_orders,
               ROUND(SUM(o.order_value)::NUMERIC, 2) AS total_spent
        FROM orders o JOIN customers c ON o.customer_id = c.customer_id
        GROUP BY o.customer_id, customer_name
        ORDER BY total_spent DESC LIMIT 10
    """)

    fig, ax = plt.subplots(figsize=(11, 5))
    colors = sns.color_palette("YlOrRd_r", len(df))
    bars = ax.barh(df["customer_name"][::-1], df["total_spent"][::-1], color=colors[::-1])
    for bar, orders in zip(bars, df["total_orders"][::-1]):
        ax.text(bar.get_width() + 10, bar.get_y() + bar.get_height() / 2,
                f"{orders} orders", va="center", fontsize=9)
    ax.set_title("Top 10 Highest-Spending Customers", fontweight="bold")
    ax.set_xlabel("Total Spent ($)")
    ax.xaxis.set_major_formatter(mticker.StrMethodFormatter("${x:,.0f}"))
    plt.tight_layout()
    save(fig, "02d_top_customers.png")


# ── Q5 : Average spend by age group ──────────────────────────────────────
def plot_spend_by_age():
    df = query("""
        SELECT CASE
            WHEN DATE_PART('year', AGE(c.date_of_birth)) < 18  THEN 'Under 18'
            WHEN DATE_PART('year', AGE(c.date_of_birth)) < 25  THEN '18-24'
            WHEN DATE_PART('year', AGE(c.date_of_birth)) < 35  THEN '25-34'
            WHEN DATE_PART('year', AGE(c.date_of_birth)) < 45  THEN '35-44'
            WHEN DATE_PART('year', AGE(c.date_of_birth)) < 60  THEN '45-59'
            ELSE '60+'
        END AS age_group,
        ROUND(AVG(o.order_value)::NUMERIC, 2) AS avg_order_value,
        ROUND(SUM(o.order_value)::NUMERIC, 2) AS total_revenue
        FROM orders o JOIN customers c ON o.customer_id = c.customer_id
        WHERE c.date_of_birth IS NOT NULL
        GROUP BY age_group ORDER BY MIN(DATE_PART('year', AGE(c.date_of_birth)))
    """)

    fig, ax = plt.subplots(figsize=(10, 5))
    colors = sns.color_palette("crest", len(df))
    bars = ax.bar(df["age_group"], df["avg_order_value"], color=colors)
    for bar, val in zip(bars, df["avg_order_value"]):
        ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.2,
                f"${val:.2f}", ha="center", va="bottom", fontsize=10, fontweight="bold")
    ax.set_title("Average Order Value by Customer Age Group", fontweight="bold")
    ax.set_xlabel("Age Group")
    ax.set_ylabel("Avg Order Value ($)")
    save(fig, "02e_spend_by_age_group.png")


# ── Q6 : Monthly unique customers trend ──────────────────────────────────
def plot_monthly_customers():
    df = query("""
        SELECT DATE_TRUNC('month', o.order_datetime)::DATE AS month,
               COUNT(DISTINCT o.customer_id) AS unique_customers,
               COUNT(o.order_id) AS total_orders
        FROM orders o GROUP BY month ORDER BY month
    """)
    df["month"] = pd.to_datetime(df["month"])

    fig, ax = plt.subplots(figsize=(14, 5))
    ax.fill_between(df["month"], df["unique_customers"], alpha=0.15, color="seagreen")
    ax.plot(df["month"], df["unique_customers"], "o-", color="seagreen",
            linewidth=2, markersize=4, label="Unique Customers")
    ax.set_title("Monthly Unique Customers Trend", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Unique Customers")
    ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    ax.legend()
    plt.tight_layout()
    save(fig, "02f_monthly_customers.png")


# ── Main ───────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    print("=" * 60)
    print("  Ooshman — Customer Analysis")
    print("=" * 60)
    plot_age_distribution()
    plot_order_frequency()
    plot_gender_by_shop()
    plot_top_customers()
    plot_spend_by_age()
    plot_monthly_customers()
    print("\nCustomer analysis complete.")
