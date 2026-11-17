-- Question 1: Who ordered what
SELECT o.id, u.email, p.name, o.quantity
FROM orders o
JOIN users u ON u.id = o.user_id
JOIN products p ON p.id = o.product_id;

-- Question 2: Sorted by order day
SELECT o.id, u.email, p.name, o.quantity,
       o.created_at::date AS order_day
FROM orders o
JOIN users u ON u.id = o.user_id
JOIN products p ON p.id = o.product_id
ORDER BY order_day;

-- Question 3: Users who never ordered
SELECT u.email
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE o.id IS NULL;

-- Question 4: Orders per status
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- Question 5: Revenue by category
SELECT p.category, SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON p.id = o.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Question 6: Top 5 customers
SELECT u.email, SUM(o.quantity) AS total_items
FROM orders o
JOIN users u ON u.id = o.user_id
GROUP BY u.email
ORDER BY total_items DESC
LIMIT 5;

-- Question 7: Above-average categories
SELECT category, AVG(price) AS avg_price
FROM products
GROUP BY category
HAVING AVG(price) > (SELECT AVG(price) FROM products);

-- Question 8: Frequent buyers
SELECT u.email, COUNT(*) AS order_count
FROM orders o
JOIN users u ON u.id = o.user_id
GROUP BY u.email
HAVING COUNT(*) > 40
ORDER BY order_count DESC;

-- Question 9: Never-ordered products
SELECT p.name
FROM products p
LEFT JOIN orders o ON o.product_id = p.id
WHERE o.id IS NULL;