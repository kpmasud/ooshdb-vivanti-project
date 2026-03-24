"""
=============================================================================
PROJECT  : Ooshman Food Business — PostgreSQL Analysis
FILE     : python/03_menu_analysis.py
PURPOSE  : Menu performance, category revenue, best sellers, pricing
           Mirrors: sql/03_menu_analysis.sql
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


# ── Q1 : Revenue by category ─────────────────────────────────────────────
def plot_revenue_by_category():
    df = query("""
        SELECT c.category_name,
               SUM(oi.quantity) AS total_qty_sold,
               ROUND(SUM(oi.line_total)::NUMERIC, 2) AS total_revenue
        FROM order_items oi
        JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
        JOIN categories c  ON mi.category_id  = c.category_id
        GROUP BY c.category_name ORDER BY total_revenue DESC
    """)

    fig, ax = plt.subplots(figsize=(12, 5))
    colors = sns.color_palette("tab10", len(df))
    bars = ax.bar(df["category_name"], df["total_revenue"] / 1e6, color=colors)
    for bar, val in zip(bars, df["total_revenue"]):
        ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.01,
                f"${val/1e6:.1f}M", ha="center", va="bottom", fontsize=8)
    ax.set_title("Total Revenue by Category", fontweight="bold")
    ax.set_xlabel("")
    ax.set_ylabel("Revenue ($M)")
    ax.tick_params(axis="x", rotation=30)
    plt.tight_layout()
    save(fig, "03a_revenue_by_category.png")


# ── Q2 : Top 15 best-selling items ───────────────────────────────────────
def plot_top_selling_items():
    df = query("""
        SELECT mi.menu_item_name, c.category_name,
               SUM(oi.quantity) AS total_qty_sold,
               ROUND(SUM(oi.line_total)::NUMERIC, 2) AS total_revenue
        FROM order_items oi
        JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
        JOIN categories c  ON mi.category_id  = c.category_id
        GROUP BY mi.menu_item_name, c.category_name
        ORDER BY total_qty_sold DESC LIMIT 15
    """)

    fig, ax = plt.subplots(figsize=(12, 6))
    colors = sns.color_palette("viridis", len(df))
    ax.barh(df["menu_item_name"][::-1], df["total_qty_sold"][::-1], color=colors)
    ax.set_title("Top 15 Best-Selling Menu Items (by Quantity)", fontweight="bold")
    ax.set_xlabel("Total Quantity Sold")
    ax.xaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    plt.tight_layout()
    save(fig, "03b_top_selling_items.png")


# ── Q3 : Top 15 highest revenue items ────────────────────────────────────
def plot_top_revenue_items():
    df = query("""
        SELECT mi.menu_item_name, c.category_name,
               ROUND(mi.price::NUMERIC, 2) AS price,
               SUM(oi.quantity) AS total_qty_sold,
               ROUND(SUM(oi.line_total)::NUMERIC, 2) AS total_revenue
        FROM order_items oi
        JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
        JOIN categories c  ON mi.category_id  = c.category_id
        GROUP BY mi.menu_item_name, c.category_name, mi.price
        ORDER BY total_revenue DESC LIMIT 15
    """)

    fig, ax = plt.subplots(figsize=(12, 6))
    colors = sns.color_palette("rocket", len(df))
    ax.barh(df["menu_item_name"][::-1], df["total_revenue"][::-1] / 1e6, color=colors)
    ax.set_title("Top 15 Highest Revenue Menu Items", fontweight="bold")
    ax.set_xlabel("Total Revenue ($M)")
    plt.tight_layout()
    save(fig, "03c_top_revenue_items.png")


# ── Q4 : Category revenue share (pie) ────────────────────────────────────
def plot_category_revenue_share():
    df = query("""
        SELECT c.category_name,
               ROUND(SUM(oi.line_total)::NUMERIC, 2) AS total_revenue,
               ROUND(SUM(oi.line_total) * 100.0 / SUM(SUM(oi.line_total)) OVER (), 1) AS revenue_pct
        FROM order_items oi
        JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
        JOIN categories c  ON mi.category_id  = c.category_id
        GROUP BY c.category_name ORDER BY total_revenue DESC
    """)

    fig, ax = plt.subplots(figsize=(9, 7))
    colors = sns.color_palette("tab10", len(df))
    wedges, texts, autotexts = ax.pie(
        df["total_revenue"], labels=df["category_name"],
        autopct="%1.1f%%", startangle=140, colors=colors,
        pctdistance=0.8
    )
    for t in autotexts:
        t.set_fontsize(8)
    ax.set_title("Revenue Share by Category", fontweight="bold")
    plt.tight_layout()
    save(fig, "03d_category_revenue_share.png")


# ── Q5 : Price range by category ─────────────────────────────────────────
def plot_price_by_category():
    df = query("""
        SELECT c.category_name,
               ROUND(MIN(mi.price)::NUMERIC, 2) AS min_price,
               ROUND(AVG(mi.price)::NUMERIC, 2) AS avg_price,
               ROUND(MAX(mi.price)::NUMERIC, 2) AS max_price
        FROM menu_items mi JOIN categories c ON mi.category_id = c.category_id
        GROUP BY c.category_name ORDER BY avg_price DESC
    """)

    fig, ax = plt.subplots(figsize=(12, 5))
    x = range(len(df))
    ax.bar(x, df["max_price"], color="lightcoral", alpha=0.5, label="Max Price")
    ax.bar(x, df["avg_price"], color="steelblue", alpha=0.8, label="Avg Price")
    ax.bar(x, df["min_price"], color="seagreen",  alpha=0.8, label="Min Price")
    ax.set_xticks(x)
    ax.set_xticklabels(df["category_name"], rotation=30, ha="right")
    ax.set_title("Menu Item Price Range by Category", fontweight="bold")
    ax.set_ylabel("Price ($)")
    ax.yaxis.set_major_formatter(mticker.StrMethodFormatter("${x:,.2f}"))
    ax.legend()
    plt.tight_layout()
    save(fig, "03e_price_by_category.png")


# ── Q6 : Orders containing each category ─────────────────────────────────
def plot_category_reach():
    df = query("""
        SELECT c.category_name,
               COUNT(DISTINCT oi.order_id) AS orders_containing,
               ROUND(AVG(oi.quantity)::NUMERIC, 2) AS avg_qty_per_order
        FROM order_items oi
        JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
        JOIN categories c  ON mi.category_id  = c.category_id
        GROUP BY c.category_name ORDER BY orders_containing DESC
    """)

    fig, ax = plt.subplots(figsize=(12, 5))
    colors = sns.color_palette("mako", len(df))
    bars = ax.barh(df["category_name"][::-1], df["orders_containing"][::-1], color=colors)
    for bar, qty in zip(bars, df["avg_qty_per_order"][::-1]):
        ax.text(bar.get_width() + 200, bar.get_y() + bar.get_height() / 2,
                f"avg {qty:.1f} qty", va="center", fontsize=8)
    ax.set_title("Orders Containing Each Category", fontweight="bold")
    ax.set_xlabel("Number of Orders")
    ax.xaxis.set_major_formatter(mticker.StrMethodFormatter("{x:,.0f}"))
    plt.tight_layout()
    save(fig, "03f_category_reach.png")


# ── Main ───────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    print("=" * 60)
    print("  Ooshman — Menu Analysis")
    print("=" * 60)
    plot_revenue_by_category()
    plot_top_selling_items()
    plot_top_revenue_items()
    plot_category_revenue_share()
    plot_price_by_category()
    plot_category_reach()
    print("\nMenu analysis complete.")
