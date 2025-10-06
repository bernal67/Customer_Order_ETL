import pandas as pd
from sqlalchemy import create_engine
import yaml, pathlib

with open("src/config.yml") as f:
    cfg = yaml.safe_load(f)

engine = create_engine(cfg["db"]["url"])
p = pathlib.Path("data/_processed")

for name in ["customers", "products", "orders"]:
    df = pd.read_parquet(p / f"{name}.parquet")
    df.to_sql(name, engine, if_exists="append", index=False, chunksize=1000)
    print("Loaded:", name)
