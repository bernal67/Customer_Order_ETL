import boto3, os, yaml

with open("src/config.yml") as f:
    cfg = yaml.safe_load(f)

s3 = boto3.client("s3", region_name=cfg["aws"]["region"])

bucket = cfg["aws"]["s3_bucket"]
prefix = cfg["aws"]["prefix"]
outdir = cfg["paths"]["local_raw"]
os.makedirs(outdir, exist_ok=True)

resp = s3.list_objects_v2(Bucket=bucket, Prefix=prefix)
for obj in resp.get("Contents", []):
    key = obj["Key"]
    if key.endswith(".csv"):
        fname = os.path.join(outdir, key.split("/")[-1])
        s3.download_file(bucket, key, fname)
        print("Downloaded:", fname)
