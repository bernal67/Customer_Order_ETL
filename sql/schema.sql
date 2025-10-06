-- Use numeric(12,2) for portability; adjust types if MySQL.
CREATE TABLE IF NOT EXISTS customers (
  customer_id   INT PRIMARY KEY,
  first_name    VARCHAR(100),
  last_name     VARCHAR(100),
  email         VARCHAR(255) UNIQUE,
  signup_date   DATE
);

CREATE TABLE IF NOT EXISTS products (
  product_id  INT PRIMARY KEY,
  name        VARCHAR(200),
  category    VARCHAR(100),
  price       NUMERIC(12,2)
);

CREATE TABLE IF NOT EXISTS orders (
  order_id     INT PRIMARY KEY,
  customer_id  INT REFERENCES customers(customer_id),
  product_id   INT REFERENCES products(product_id),
  quantity     INT,
  unit_price   NUMERIC(12,2),
  order_date   DATE,
  status       VARCHAR(50),
  total_amount NUMERIC(12,2)
);
