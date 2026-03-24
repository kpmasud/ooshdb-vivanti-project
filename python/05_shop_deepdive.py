"""
=============================================================================
PROJECT  : Ooshman Food Business — PostgreSQL Analysis
FILE     : python/05_shop_deepdive.py
PURPOSE  : Shop vs shop comparison, top items per shop, staff, payment mix
           Mirrors: sql/05_shop_deepdive.sql
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


# ── Q1 : Full KPI comparison ─────────────────────────────────────────────
def plot_shop_kpis():
    df = query("""
        SELECT s.name AS shop_name,
               COUNT(DISTINCT o.customer_id) AS unique_customers,
               COUNT(o.order_id) AS total_orders,
               ROUND(SUM(o.order_value)::NUMERIC, 2) AS total_revenue,
               ROUND(AVG(o.order_value)::NUMERIC, 2) AS avg_order_value,
               ROUND(SUM(o.order_value) * 100.0 / SUM(SUM(o.order_value)) OVER (), 1) AS revenue_share_pct
        FROM orders o JOIN shops s ON o.shop_id = s.shop_id
        GROUP BY s.shop_id, s.name ORDER BY total_revenue DESC
    """)

    metrics = ["total_orders", "unique_customers", "avg_order_value"]
    labels  = ["Total Orders", "Unique Customers", "Avg Order Value ($)"]

    fig, axes = plt.subplots(1, 3, figsize=(15, 5))
    fig.suptitle("Shop KPI Comparison", fontweight="bold", fontsize=14)

    for ax, col, label in zip(axes, metrics, labels):
        colors = [SHOP_COLOURS.get(s, "steelblue") for s in df["shop_name"]]
        bars = ax.bar(df["shop_name"], df[col], color=colors)
        for bar, val in zip(bars, df[col]):
            ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() * 1.01,
                    f"{val:,.0f}" if col != "avg_order_value" else f"${val:.2f}",
                    ha="center", va="bottom", fontsize=9, fontweight="bold")
        ax.set_title(label, fontweight="bold")
        ax.set_xlabel("")
        ax.tick_params(axis="x", rotation=12)
        if col != "avg_order_value":
            ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))

    plt.tight_layout()
    save(fig, "05a_shop_kpi_comparison.png")


# ── Q2 : Monthly revenue per shop ─────────────────────────────────────────
def plot_shop_monthly_revenue():
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
        ax.plot(grp["month"], grp["revenue"] / 1e3, linewidth=2.5,
                label=shop, color=SHOP_COLOURS.get(shop), marker="o", markersize=3)
    ax.set_title("Monthly Revenue Trend by Shop", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Revenue ($K)")
    ax.legend(title="Shop")
    plt.tight_layout()
    save(fig, "05b_shop_monthly_revenue.png")


# ── Q3 : Top 5 items per shop ─────────────────────────────────────────────
def plot_top_items_per_shop():
    df = query("""
        WITH ranked AS (
            SELECT s.name AS shop_name, mi.menu_item_name,
                   SUM(oi.quantity) AS total_qty,
                   RANK() OVER (PARTITION BY s.shop_id ORDER BY SUM(oi.quantity) DESC) AS rnk
            FROM order_items oi
            JOIN orders o      ON oi.order_id     = o.order_id
            JOIN shops s       ON o.shop_id        = s.shop_id
            JOIN menu_items mi ON oi.menu_item_id  = mi.menu_item_id
            GROUP BY s.shop_id, s.name, mi.menu_item_name
        )
        SELECT shop_name, menu_item_name, total_qty FROM ranked
        WHERE rnk <= 5 ORDER BY shop_name, rnk
    """)

    shops = df["shop_name"].unique()
    fig, axes = plt.subplots(1, len(shops), figsize=(15, 5))
    fig.suptitle("Top 5 Best-Selling Items per Shop", fontweight="bold", fontsize=13)

    for ax, shop in zip(axes, shops):
        sub = df[df["shop_name"] == shop]
        color = SHOP_COLOURS.get(shop, "steelblue")
        ax.barh(sub["menu_item_name"][::-1], sub["total_qty"][::-1], color=color)
        ax.set_title(shop.replace("Ooshman ", ""), fontweight="bold")
        ax.set_xlabel("Qty Sold")
        ax.xaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))

    plt.tight_layout()
    save(fig, "05c_top_items_per_shop.png")


# ── Q4 : Staff breakdown by shop ──────────────────────────────────────────
def plot_staff_by_shop():
    df = query("""
        SELECT s.name AS shop_name, st.role, COUNT(*) AS staff_count
        FROM staff st JOIN shops s ON st.shop_id = s.shop_id
        GROUP BY s.name, st.role ORDER BY s.name, st.role
    """)
    pivot = df.pivot(index="shop_name", columns="role", values="staff_count").fillna(0)

    fig, ax = plt.subplots(figsize=(10, 5))
    pivot.plot(kind="bar", ax=ax, colormap="Set2", width=0.5)
    ax.set_title("Staff Count by Role per Shop", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Number of Staff")
    ax.tick_params(axis="x", rotation=10)
    ax.legend(title="Role")
    for container in ax.containers:
        ax.bar_label(container, fmt="%.0f", padding=2, fontsize=9)
    plt.tight_layout()
    save(fig, "05d_staff_by_shop.png")


# ── Q5 : Payment method by shop ───────────────────────────────────────────
def plot_payment_by_shop():
    df = query("""
        SELECT s.name AS shop_name, pm.payment_method_name,
               COUNT(o.order_id) AS orders,
               ROUND(COUNT(o.order_id) * 100.0 /
                   SUM(COUNT(o.order_id)) OVER (PARTITION BY s.shop_id), 1) AS pct
        FROM orders o
        JOIN shops s ON o.shop_id = s.shop_id
        JOIN payment_methods pm ON o.payment_id = pm.payment_id
        GROUP BY s.shop_id, s.name, pm.payment_method_name
        ORDER BY s.name, orders DESC
    """)
    pivot = df.pivot(index="shop_name", columns="payment_method_name", values="pct").fillna(0)

    fig, ax = plt.subplots(figsize=(11, 5))
    pivot.plot(kind="bar", ax=ax, colormap="tab10", width=0.6)
    ax.set_title("Payment Method Mix by Shop (%)", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Share of Orders (%)")
    ax.tick_params(axis="x", rotation=10)
    ax.legend(title="Payment Method", bbox_to_anchor=(1.01, 1), loc="upper left")
    for container in ax.containers:
        ax.bar_label(container, fmt="%.1f%%", padding=2, fontsize=8)
    plt.tight_layout()
    save(fig, "05e_payment_by_shop.png")


# ── Q6 : Average order value per shop by year ─────────────────────────────
def plot_shop_avg_order_by_year():
    df = query("""
        SELECT EXTRACT(YEAR FROM o.order_datetime)::INT AS year,
               s.name AS shop_name,
               ROUND(AVG(o.order_value)::NUMERIC, 2) AS avg_order_value,
               COUNT(o.order_id) AS orders
        FROM orders o JOIN shops s ON o.shop_id = s.shop_id
        GROUP BY year, s.shop_id, s.name ORDER BY year, s.name
    """)

    fig, ax = plt.subplots(figsize=(10, 5))
    for shop, grp in df.groupby("shop_name"):
        ax.plot(grp["year"], grp["avg_order_value"], "o-", linewidth=2.5,
                markersize=10, label=shop, color=SHOP_COLOURS.get(shop))
        for _, row in grp.iterrows():
            ax.annotate(f"${row['avg_order_value']:.2f}",
                        (row["year"], row["avg_order_value"]),
                        textcoords="offset points", xytext=(0, 8),
                        ha="center", fontsize=9)
    ax.set_title("Average Order Value per Shop by Year", fontweight="bold")
    ax.set_xlabel("Year")
    ax.set_ylabel("Avg Order Value ($)")
    ax.xaxis.set_major_locator(mticker.MultipleLocator(1))
    ax.legend(title="Shop")
    plt.tight_layout()
    save(fig, "05f_shop_avg_order_by_year.png")


# ── Main ───────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    print("=" * 60)
    print("  Ooshman — Shop Deep-Dive Analysis")
    print("=" * 60)
    plot_shop_kpis()
    plot_shop_monthly_revenue()
    plot_top_items_per_shop()
    plot_staff_by_shop()
    plot_payment_by_shop()
    plot_shop_avg_order_by_year()
    print("\nShop deep-dive analysis complete.")
