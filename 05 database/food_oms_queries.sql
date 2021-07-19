-- create tables
CREATE TABLE customers (id INT PRIMARY KEY NOT NULL, name VARCHAR(50), phone VARCHAR(50) UNIQUE);
CREATE TABLE orders (id INT PRIMARY KEY NOT NULL, customer_id INT, order_date DATE, total_price DECIMAL);
CREATE TABLE order_details (order_id INT, item_id INT, quantity INT);

-- insert dummy values
INSERT INTO customers
VALUES (1, "Alif", "08123"),
       (2, "Bambang", "08124"),
       (3, "Chacha", "08125"),
       (4, "Dityo", "08126"),
       (5, "Erma", "08127");
INSERT INTO orders
VALUES (1, 1, "2021-07-17", 0),
       (2, 2, "2021-07-15", 0),
       (3, 3, "2021-07-10", 0),
       (4, 3, "2021-07-16", 0),
       (5, 4, "2021-07-14", 0);
INSERT INTO order_details
VALUES (1, 1, 1),
       (2, 3, 2),
       (2, 4, 1),
       (3, 7, 3),
       (4, 2, 2),
       (5, 5, 1),
       (4, 3, 1);
UPDATE orders
JOIN (
    SELECT order_id, SUM(items.price * order_details.quantity) as sum_price
    FROM orders
    JOIN order_details ON orders.id = order_details.order_id
    JOIN items ON items.id = order_details.item_id
    GROUP BY orders.id
) orders_items
ON orders.id = orders_items.order_id
SET orders.total_price = orders_items.sum_price;

-- query to show all order details with customer information
SELECT orders.id as "Order ID", orders.order_date as "Order Date", customers.name as "Customer name", customers.phone as "Customer phone", orders.total_price as "Total", GROUP_CONCAT(concat(order_details.quantity, " ", items.name) SEPARATOR ", ") as "Items bought"
FROM orders
JOIN order_details ON orders.id = order_details.order_id
JOIN customers ON customers.id = orders.customer_id
JOIN items ON items.id = order_details.item_id
GROUP BY orders.id;

-- query result
-- +----------+------------+---------------+----------------+--------+--------------------------------+
-- | Order ID | Order Date | Customer name | Customer phone | Total  | Items bought                   |
-- +----------+------------+---------------+----------------+--------+--------------------------------+
-- |        1 | 2021-07-17 | Alif          | 08123          |   2000 | 1 Ice Water                    |
-- |        2 | 2021-07-15 | Bambang       | 08124          |  98000 | 1 Green Tea Latte, 2 Spaghetti |
-- |        3 | 2021-07-10 | Chacha        | 08125          | 108000 | 3 Cordon Bleu                  |
-- |        4 | 2021-07-16 | Chacha        | 08125          |  40000 | 2 Air Putih, 1 Spaghetti       |
-- |        5 | 2021-07-14 | Dityo         | 08126          |  15000 | 1 Orange Juice                 |
-- +----------+------------+---------------+----------------+--------+--------------------------------+
-- 5 rows in set (0.00 sec)