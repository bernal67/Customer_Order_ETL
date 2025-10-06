import pandas as pd
from pathlib import Path

d = Path("data")
customers = pd.read_csv(d / "customers.csv")
products  = pd.read_csv(d / "products.csv")
orders    = pd.read_csv(d / "orders.csv")

# Basic cleanup
orders["order_date"] = pd.to_datetime(orders["order_date"])
orders["unit_price"] = orders["unit_price"].fillna(0)
orders["quantity"]   = orders["quantity"].fillna(0).astype(int)
orders["total_amount"] = orders["unit_price"] * orders["quantity"]

# Save transformed parquet outputs
(d / "_processed").mkdir(exist_ok=True)
orders.to_parquet(d / "_processed/orders.parquet", index=False)
customers.to_parquet(d / "_processed/customers.parquet", index=False)
products.to_parquet(d / "_processed/products.parquet", index=False)
print("Transformed & saved parquet files.")
