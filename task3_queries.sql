-- Create tables
CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    country TEXT
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL NOT NULL
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    order_date TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert sample data
INSERT INTO customers (name, email, country) VALUES
('Alice', 'alice@example.com', 'USA'),
('Bob', 'bob@example.com', 'India'),
('Charlie', 'charlie@example.com', 'UK');

INSERT INTO products (name, price) VALUES
('Laptop', 1000.00),
('Phone', 600.00),
('Tablet', 400.00);

INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2024-05-01'),
(1, 2, 2, '2024-05-03'),
(2, 2, 1, '2024-05-05'),
(3, 3, 3, '2024-05-07');

-- Query 1: Total number of customers by country
SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country;

-- Query 2: Total order amount per customer
SELECT c.name, SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
GROUP BY c.name;

-- Query 3: Customers who bought more than one product
SELECT c.name, COUNT(DISTINCT o.product_id) AS products_bought
FROM orders o
JOIN customers c ON o.customer_id = c.id
GROUP BY c.id
HAVING products_bought > 1;

-- Query 4: Create a view of top customers
CREATE VIEW top_customers AS
SELECT c.id, c.name, SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
GROUP BY c.id
ORDER BY total_spent DESC;
