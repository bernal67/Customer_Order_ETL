-- Null checks
SELECT 'orders.total_amount nulls' AS test_name, COUNT(*) AS cnt
FROM orders WHERE total_amount IS NULL;

-- Duplicate order_id check
SELECT 'dup order_id' AS test_name, order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Date range sanity (no future dates)
SELECT 'future orders' AS test_name, COUNT(*)
FROM orders
WHERE order_date > CURRENT_DATE;
