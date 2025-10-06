-- Monthly revenue & AOV
WITH o AS (
  SELECT date_trunc('month', order_date) AS month,
         SUM(total_amount) AS revenue,
         AVG(total_amount) AS aov
  FROM orders
  WHERE status = 'completed'
  GROUP BY 1
)
SELECT * FROM o ORDER BY month;

-- Top 5 products by revenue
SELECT p.name, SUM(o.total_amount) AS revenue
FROM orders o
JOIN products p USING (product_id)
WHERE status = 'completed'
GROUP BY 1
ORDER BY revenue DESC
LIMIT 5;

-- LTV (simple): total revenue per customer
SELECT c.customer_id, c.email, COALESCE(SUM(o.total_amount),0) AS ltv
FROM customers c
LEFT JOIN orders o USING (customer_id)
GROUP BY 1,2
ORDER BY ltv DESC;

-- Repeat purchase rate (>=2 completed orders)
WITH completed AS (
  SELECT customer_id, COUNT(*) cnt
  FROM orders
  WHERE status = 'completed'
  GROUP BY 1
)
SELECT
  SUM(CASE WHEN cnt >= 2 THEN 1 ELSE 0 END)::decimal
  / NULLIF(COUNT(*),0) AS repeat_rate
FROM completed;
