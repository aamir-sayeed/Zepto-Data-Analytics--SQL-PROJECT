# Zepto-Data-Analytics--SQL-PROJECT
Zepto Data Analytics
- The project analyzes a real Zepto e‑commerce inventory dataset with 3,732 rows and 9 columns; each row is a unique SKU, not just a product name, which explains only 1,681 unique names across 3.7k SKUs.
- Stock status split shows about 3,200 SKUs in stock versus 453 out of stock, helping flag immediate replenishment priorities and missed‑revenue risks.
- Data cleaning includes removing zero‑MRP records and converting prices from paise to rupees; encoding issues are fixed by saving the CSV as UTF‑8 before import into PostgreSQL.
- Business queries estimate category‑level revenue using discounted selling price × available quantity, identify high‑MRP/low‑discount items, and rank top discounts (many ≥50% off) to guide promotions and pricing strategy.
- Additional analyses segment products by weight bands (low/medium/bulk), compute price‑per‑gram for items ≥100 g to assess value for money, and list duplicate product names that map to multiple SKUs due to pack size or category variations.

