-- Checking all data is loaded properly
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM reviews;


-- Checking for NULL values
-- Expected Cancelled order = NULL delivery date
SELECT 
    COUNT(*) AS missing_delivered_date
FROM orders
WHERE order_delivered_customer_date IS NULL;

-- Customer without any Customer ID is invalid
SELECT COUNT(*) 
FROM customers
WHERE customer_id IS NULL;

-- Reviews with no score is not required
SELECT COUNT(*) 
FROM reviews
WHERE review_score IS NULL;

-- Checking if one order id is linked to only one order
-- Order id cant be same for 2 different orders
SELECT order_id, COUNT(*) 
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Single order can have more than one payment linked to it
SELECT order_id, COUNT(*) 
FROM payments
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Checking Date Time format
SELECT 
    order_purchase_timestamp,
    order_delivered_customer_date
FROM orders
LIMIT 10;


-- Creating VIEWS for ease of further analysis
CREATE VIEW clean_orders AS
SELECT 
    order_id,
    customer_id,
    order_status,
    DATE(order_purchase_timestamp) AS order_date,
    DATE(order_delivered_customer_date) AS delivered_date,
    DATE(order_estimated_delivery_date) AS estimated_date
FROM orders;

CREATE VIEW order_delivery_metrics AS
SELECT 
    order_id,
    DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) AS delivery_time,
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS delay_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- Checking for Order Status
SELECT 
    order_status,
    COUNT(*) 
FROM orders
GROUP BY order_status;
