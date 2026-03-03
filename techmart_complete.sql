-- =============================================================================
-- TechMart E-commerce Database - Complete Setup Script
-- PostgreSQL Full Database Creation with Schema and Sample Data
-- =============================================================================
-- This script creates the entire TechMart database from scratch
-- Run this single file to set up everything
-- =============================================================================

-- =============================================================================
-- CLEANUP: Drop existing tables (in correct order due to foreign keys)
-- =============================================================================
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- =============================================================================
-- TABLE: customers
-- =============================================================================
CREATE TABLE customers (
    customer_id     SERIAL PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    phone           VARCHAR(20),
    address         VARCHAR(200),
    city            VARCHAR(50),
    state           VARCHAR(50),
    postal_code     VARCHAR(20),
    country         VARCHAR(50) DEFAULT 'USA',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- TABLE: products
-- =============================================================================
CREATE TABLE products (
    product_id      SERIAL PRIMARY KEY,
    product_name    VARCHAR(100) NOT NULL,
    description     TEXT,
    category        VARCHAR(50) NOT NULL CHECK (category IN ('Electronics', 'Accessories', 'Home Office', 'Furniture', 'Stationery')),
    price           DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity  INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- TABLE: orders
-- =============================================================================
CREATE TABLE orders (
    order_id        SERIAL PRIMARY KEY,
    customer_id     INTEGER NOT NULL REFERENCES customers(customer_id),
    order_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status          VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    shipping_address VARCHAR(200),
    total_amount    DECIMAL(10, 2) DEFAULT 0.00
);

-- =============================================================================
-- TABLE: order_items
-- =============================================================================
CREATE TABLE order_items (
    order_item_id   SERIAL PRIMARY KEY,
    order_id        INTEGER NOT NULL REFERENCES orders(order_id),
    product_id      INTEGER NOT NULL REFERENCES products(product_id),
    quantity        INTEGER NOT NULL CHECK (quantity > 0),
    unit_price      DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    subtotal        DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);

-- =============================================================================
-- INDEXES for better query performance
-- =============================================================================
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_customers_email ON customers(email);

-- =============================================================================
-- DATA: Insert 20 customers
-- =============================================================================
INSERT INTO customers (first_name, last_name, email, phone, address, city, state, postal_code, country) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '123 Main Street', 'New York', 'NY', '10001', 'USA'),
('Emily', 'Johnson', 'emily.johnson@email.com', '555-0102', '456 Oak Avenue', 'Los Angeles', 'CA', '90001', 'USA'),
('Michael', 'Williams', 'michael.williams@email.com', '555-0103', '789 Pine Road', 'Chicago', 'IL', '60601', 'USA'),
('Sarah', 'Brown', 'sarah.brown@email.com', '555-0104', '321 Elm Street', 'Houston', 'TX', '77001', 'USA'),
('David', 'Jones', 'david.jones@email.com', '555-0105', '654 Maple Drive', 'Phoenix', 'AZ', '85001', 'USA'),
('Jessica', 'Garcia', 'jessica.garcia@email.com', '555-0106', '987 Cedar Lane', 'Philadelphia', 'PA', '19101', 'USA'),
('James', 'Miller', 'james.miller@email.com', '555-0107', '147 Birch Court', 'San Antonio', 'TX', '78201', 'USA'),
('Amanda', 'Davis', 'amanda.davis@email.com', '555-0108', '258 Walnut Way', 'San Diego', 'CA', '92101', 'USA'),
('Robert', 'Martinez', 'robert.martinez@email.com', '555-0109', '369 Spruce Blvd', 'Dallas', 'TX', '75201', 'USA'),
('Jennifer', 'Anderson', 'jennifer.anderson@email.com', '555-0110', '741 Willow Path', 'San Jose', 'CA', '95101', 'USA'),
('Christopher', 'Taylor', 'christopher.taylor@email.com', '555-0111', '852 Ash Street', 'Austin', 'TX', '78701', 'USA'),
('Ashley', 'Thomas', 'ashley.thomas@email.com', '555-0112', '963 Cherry Lane', 'Jacksonville', 'FL', '32201', 'USA'),
('Matthew', 'Hernandez', 'matthew.hernandez@email.com', '555-0113', '159 Hickory Drive', 'Fort Worth', 'TX', '76101', 'USA'),
('Stephanie', 'Moore', 'stephanie.moore@email.com', '555-0114', '357 Poplar Avenue', 'Columbus', 'OH', '43201', 'USA'),
('Daniel', 'Martin', 'daniel.martin@email.com', '555-0115', '468 Sycamore Road', 'Charlotte', 'NC', '28201', 'USA'),
('Nicole', 'Jackson', 'nicole.jackson@email.com', '555-0116', '579 Magnolia Court', 'San Francisco', 'CA', '94101', 'USA'),
('Andrew', 'Thompson', 'andrew.thompson@email.com', '555-0117', '680 Dogwood Way', 'Indianapolis', 'IN', '46201', 'USA'),
('Rachel', 'White', 'rachel.white@email.com', '555-0118', '791 Redwood Lane', 'Seattle', 'WA', '98101', 'USA'),
('Joshua', 'Lopez', 'joshua.lopez@email.com', '555-0119', '802 Palm Street', 'Denver', 'CO', '80201', 'USA'),
('Lauren', 'Lee', 'lauren.lee@email.com', '555-0120', '913 Cypress Blvd', 'Boston', 'MA', '02101', 'USA');

-- =============================================================================
-- DATA: Insert 15 products (3 per category)
-- =============================================================================
INSERT INTO products (product_name, description, category, price, stock_quantity) VALUES
-- Electronics (3 products)
('Wireless Bluetooth Headphones', 'Premium noise-cancelling wireless headphones with 30-hour battery life', 'Electronics', 149.99, 50),
('USB-C Hub 7-in-1', 'Multi-port USB-C hub with HDMI, USB 3.0, SD card reader', 'Electronics', 49.99, 100),
('Portable Power Bank 20000mAh', 'High-capacity portable charger with fast charging support', 'Electronics', 39.99, 75),
-- Accessories (3 products)
('Laptop Sleeve 15 inch', 'Water-resistant neoprene laptop sleeve with padded interior', 'Accessories', 24.99, 120),
('Wireless Mouse', 'Ergonomic wireless mouse with adjustable DPI settings', 'Accessories', 29.99, 85),
('Webcam HD 1080p', 'Full HD webcam with built-in microphone and privacy cover', 'Accessories', 59.99, 60),
-- Home Office (3 products)
('LED Desk Lamp', 'Adjustable LED desk lamp with multiple brightness levels', 'Home Office', 34.99, 90),
('Monitor Stand Riser', 'Wooden monitor stand with storage drawer and USB ports', 'Home Office', 44.99, 55),
('Cable Management Kit', 'Complete cable organization set with clips and sleeves', 'Home Office', 19.99, 150),
-- Furniture (3 products)
('Ergonomic Office Chair', 'Adjustable lumbar support office chair with breathable mesh', 'Furniture', 299.99, 25),
('Standing Desk Converter', 'Height-adjustable sit-stand desk converter for laptops', 'Furniture', 179.99, 30),
('Keyboard Tray Under Desk', 'Clamp-on sliding keyboard tray with mouse pad', 'Furniture', 54.99, 40),
-- Stationery (3 products)
('Notebook Set 3-Pack', 'Premium hardcover notebooks with dotted pages', 'Stationery', 18.99, 200),
('Desk Organizer', 'Multi-compartment desk organizer for pens and supplies', 'Stationery', 22.99, 110),
('Sticky Notes Variety Pack', 'Assorted colors and sizes sticky notes bundle', 'Stationery', 12.99, 250);

-- =============================================================================
-- DATA: Insert 35 orders
-- =============================================================================
INSERT INTO orders (customer_id, order_date, status, shipping_address, total_amount) VALUES
-- Delivered orders (10)
(1, '2025-12-01 10:30:00', 'delivered', '123 Main Street, New York, NY 10001', 199.98),
(2, '2025-12-03 14:15:00', 'delivered', '456 Oak Avenue, Los Angeles, CA 90001', 149.99),
(3, '2025-12-05 09:45:00', 'delivered', '789 Pine Road, Chicago, IL 60601', 74.98),
(4, '2025-12-07 16:20:00', 'delivered', '321 Elm Street, Houston, TX 77001', 329.98),
(5, '2025-12-10 11:00:00', 'delivered', '654 Maple Drive, Phoenix, AZ 85001', 89.98),
(6, '2025-12-12 13:30:00', 'delivered', '987 Cedar Lane, Philadelphia, PA 19101', 234.97),
(7, '2025-12-15 08:45:00', 'delivered', '147 Birch Court, San Antonio, TX 78201', 54.97),
(8, '2025-12-18 15:10:00', 'delivered', '258 Walnut Way, San Diego, CA 92101', 179.99),
(9, '2025-12-20 10:25:00', 'delivered', '369 Spruce Blvd, Dallas, TX 75201', 109.96),
(10, '2025-12-22 12:40:00', 'delivered', '741 Willow Path, San Jose, CA 95101', 299.99),
-- Shipped orders (8)
(11, '2026-01-05 09:15:00', 'shipped', '852 Ash Street, Austin, TX 78701', 184.98),
(12, '2026-01-08 14:30:00', 'shipped', '963 Cherry Lane, Jacksonville, FL 32201', 49.99),
(13, '2026-01-10 11:45:00', 'shipped', '159 Hickory Drive, Fort Worth, TX 76101', 359.98),
(1, '2026-01-12 16:00:00', 'shipped', '123 Main Street, New York, NY 10001', 94.97),
(3, '2026-01-15 10:20:00', 'shipped', '789 Pine Road, Chicago, IL 60601', 224.98),
(5, '2026-01-18 13:35:00', 'shipped', '654 Maple Drive, Phoenix, AZ 85001', 70.97),
(14, '2026-01-20 08:50:00', 'shipped', '357 Poplar Avenue, Columbus, OH 43201', 149.99),
(15, '2026-01-22 15:05:00', 'shipped', '468 Sycamore Road, Charlotte, NC 28201', 44.99),
-- Processing orders (7)
(16, '2026-02-01 10:00:00', 'processing', '579 Magnolia Court, San Francisco, CA 94101', 109.97),
(17, '2026-02-03 12:15:00', 'processing', '680 Dogwood Way, Indianapolis, IN 46201', 89.98),
(18, '2026-02-05 14:30:00', 'processing', '791 Redwood Lane, Seattle, WA 98101', 239.97),
(2, '2026-02-07 09:45:00', 'processing', '456 Oak Avenue, Los Angeles, CA 90001', 50.97),
(4, '2026-02-10 11:00:00', 'processing', '321 Elm Street, Houston, TX 77001', 119.97),
(19, '2026-02-12 16:20:00', 'processing', '802 Palm Street, Denver, CO 80201', 84.98),
(20, '2026-02-15 13:35:00', 'processing', '913 Cypress Blvd, Boston, MA 02101', 172.97),
-- Pending orders (6)
(6, '2026-02-20 08:00:00', 'pending', '987 Cedar Lane, Philadelphia, PA 19101', 234.98),
(8, '2026-02-22 10:30:00', 'pending', '258 Walnut Way, San Diego, CA 92101', 54.99),
(10, '2026-02-24 14:45:00', 'pending', '741 Willow Path, San Jose, CA 95101', 299.99),
(12, '2026-02-26 09:15:00', 'pending', '963 Cherry Lane, Jacksonville, FL 32201', 82.95),
(14, '2026-02-27 11:30:00', 'pending', '357 Poplar Avenue, Columbus, OH 43201', 234.98),
(16, '2026-02-28 15:00:00', 'pending', '579 Magnolia Court, San Francisco, CA 94101', 59.99),
-- Cancelled orders (4)
(7, '2026-01-02 10:00:00', 'cancelled', '147 Birch Court, San Antonio, TX 78201', 149.99),
(9, '2026-01-25 12:30:00', 'cancelled', '369 Spruce Blvd, Dallas, TX 75201', 299.99),
(11, '2026-02-08 14:15:00', 'cancelled', '852 Ash Street, Austin, TX 78701', 179.99),
(13, '2026-02-18 09:45:00', 'cancelled', '159 Hickory Drive, Fort Worth, TX 76101', 44.99);

-- =============================================================================
-- DATA: Insert 55 order items
-- =============================================================================
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Order 1: Wireless Headphones + USB-C Hub
(1, 1, 1, 149.99),
(1, 2, 1, 49.99),
-- Order 2: Wireless Headphones
(2, 1, 1, 149.99),
-- Order 3: Laptop Sleeve + USB-C Hub
(3, 4, 1, 24.99),
(3, 2, 1, 49.99),
-- Order 4: Ergonomic Office Chair + Wireless Mouse
(4, 10, 1, 299.99),
(4, 5, 1, 29.99),
-- Order 5: Webcam + Wireless Mouse
(5, 6, 1, 59.99),
(5, 5, 1, 29.99),
-- Order 6: Standing Desk Converter + Desk Lamp + Cable Management
(6, 11, 1, 179.99),
(6, 7, 1, 34.99),
(6, 9, 1, 19.99),
-- Order 7: Notebook Set + Desk Organizer + Sticky Notes
(7, 13, 1, 18.99),
(7, 14, 1, 22.99),
(7, 15, 1, 12.99),
-- Order 8: Standing Desk Converter
(8, 11, 1, 179.99),
-- Order 9: Power Bank + Laptop Sleeve x2 + Cable Management
(9, 3, 1, 39.99),
(9, 4, 2, 24.99),
(9, 9, 1, 19.99),
-- Order 10: Ergonomic Office Chair
(10, 10, 1, 299.99),
-- Order 11: Wireless Headphones + Desk Lamp
(11, 1, 1, 149.99),
(11, 7, 1, 34.99),
-- Order 12: USB-C Hub
(12, 2, 1, 49.99),
-- Order 13: Ergonomic Office Chair + Webcam
(13, 10, 1, 299.99),
(13, 6, 1, 59.99),
-- Order 14: Power Bank + Wireless Mouse + Laptop Sleeve
(14, 3, 1, 39.99),
(14, 5, 1, 29.99),
(14, 4, 1, 24.99),
-- Order 15: Standing Desk Converter + Monitor Stand
(15, 11, 1, 179.99),
(15, 8, 1, 44.99),
-- Order 16: LED Desk Lamp + Desk Organizer + Sticky Notes
(16, 7, 1, 34.99),
(16, 14, 1, 22.99),
(16, 15, 1, 12.99),
-- Order 17: Webcam + Wireless Mouse
(17, 6, 1, 59.99),
(17, 5, 1, 29.99),
-- Order 18: Wireless Headphones + USB-C Hub + Power Bank
(18, 1, 1, 149.99),
(18, 2, 1, 49.99),
(18, 3, 1, 39.99),
-- Order 19: Notebook Set x2 + Sticky Notes
(19, 13, 2, 18.99),
(19, 15, 1, 12.99),
-- Order 20: Keyboard Tray + Monitor Stand + Cable Management
(20, 12, 1, 54.99),
(20, 8, 1, 44.99),
(20, 9, 1, 19.99),
-- Order 21: Webcam + Laptop Sleeve
(21, 6, 1, 59.99),
(21, 4, 1, 24.99),
-- Order 22: Ergonomic Office Chair
(22, 10, 1, 299.99),
-- Order 23: Wireless Headphones + Desk Organizer
(23, 1, 1, 149.99),
(23, 14, 1, 22.99),
-- Order 24: Keyboard Tray
(24, 12, 1, 54.99),
-- Order 25: Standing Desk Converter + Keyboard Tray
(25, 11, 1, 179.99),
(25, 12, 1, 54.99),
-- Order 26: Notebook Set x3 + Desk Organizer + Sticky Notes x2
(26, 13, 3, 18.99),
(26, 14, 1, 22.99),
(26, 15, 2, 12.99),
-- Cancelled orders still have items recorded
(32, 1, 1, 149.99),
(33, 10, 1, 299.99),
(34, 11, 1, 179.99),
(35, 8, 1, 44.99);

-- =============================================================================
-- USEFUL VIEWS (Optional)
-- =============================================================================

-- View: Order summary with customer info
CREATE OR REPLACE VIEW order_summary AS
SELECT 
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    o.order_date,
    o.status,
    o.total_amount,
    COUNT(oi.order_item_id) AS item_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.first_name, c.last_name, c.email, o.order_date, o.status, o.total_amount;

-- View: Product sales summary
CREATE OR REPLACE VIEW product_sales AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price AS current_price,
    COALESCE(SUM(oi.quantity), 0) AS total_sold,
    COALESCE(SUM(oi.subtotal), 0) AS total_revenue
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.status != 'cancelled'
GROUP BY p.product_id, p.product_name, p.category, p.price;

-- View: Customer order statistics
CREATE OR REPLACE VIEW customer_stats AS
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(CASE WHEN o.status != 'cancelled' THEN o.total_amount ELSE 0 END), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city, c.state;

-- =============================================================================
-- VERIFICATION QUERIES
-- =============================================================================
-- Run these to verify the data was inserted correctly:

-- SELECT 'Customers' AS table_name, COUNT(*) AS row_count FROM customers
-- UNION ALL SELECT 'Products', COUNT(*) FROM products
-- UNION ALL SELECT 'Orders', COUNT(*) FROM orders
-- UNION ALL SELECT 'Order Items', COUNT(*) FROM order_items;

-- SELECT status, COUNT(*) FROM orders GROUP BY status ORDER BY status;

-- SELECT category, COUNT(*) FROM products GROUP BY category ORDER BY category;

-- =============================================================================
-- END OF SCRIPT
-- =============================================================================
