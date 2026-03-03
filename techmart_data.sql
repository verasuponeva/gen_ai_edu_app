-- =============================================================================
-- ByteBazaar E-commerce Database - Sample Data
-- PostgreSQL Data Insertion Script
-- =============================================================================

-- =============================================================================
-- INSERT CUSTOMERS (20 customers)
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
-- INSERT PRODUCTS (15 products across 5 categories)
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
-- INSERT ORDERS (35 orders with various statuses)
-- =============================================================================
INSERT INTO orders (customer_id, order_date, status, shipping_address, total_amount) VALUES
-- Delivered orders (10)
(1, '2025-12-01 10:30:00', 'delivered', '123 Main Street, New York, NY 10001', 199.98),
(2, '2025-12-03 14:15:00', 'delivered', '456 Oak Avenue, Los Angeles, CA 90001', 149.99),
(3, '2025-12-05 09:45:00', 'delivered', '789 Pine Road, Chicago, IL 60601', 74.98),
(4, '2025-12-07 16:20:00', 'delivered', '321 Elm Street, Houston, TX 77001', 329.98),
(5, '2025-12-10 11:00:00', 'delivered', '654 Maple Drive, Phoenix, AZ 85001', 89.98),
(6, '2025-12-12 13:30:00', 'delivered', '987 Cedar Lane, Philadelphia, PA 19101', 234.97),
(7, '2025-12-15 08:45:00', 'delivered', '147 Birch Court, San Antonio, TX 78201', 54.98),
(8, '2025-12-18 15:10:00', 'delivered', '258 Walnut Way, San Diego, CA 92101', 179.99),
(9, '2025-12-20 10:25:00', 'delivered', '369 Spruce Blvd, Dallas, TX 75201', 119.97),
(10, '2025-12-22 12:40:00', 'delivered', '741 Willow Path, San Jose, CA 95101', 299.99),

-- Shipped orders (8)
(11, '2026-01-05 09:15:00', 'shipped', '852 Ash Street, Austin, TX 78701', 184.98),
(12, '2026-01-08 14:30:00', 'shipped', '963 Cherry Lane, Jacksonville, FL 32201', 49.99),
(13, '2026-01-10 11:45:00', 'shipped', '159 Hickory Drive, Fort Worth, TX 76101', 359.97),
(1, '2026-01-12 16:00:00', 'shipped', '123 Main Street, New York, NY 10001', 94.97),
(3, '2026-01-15 10:20:00', 'shipped', '789 Pine Road, Chicago, IL 60601', 224.98),
(5, '2026-01-18 13:35:00', 'shipped', '654 Maple Drive, Phoenix, AZ 85001', 69.98),
(14, '2026-01-20 08:50:00', 'shipped', '357 Poplar Avenue, Columbus, OH 43201', 149.99),
(15, '2026-01-22 15:05:00', 'shipped', '468 Sycamore Road, Charlotte, NC 28201', 44.99),

-- Processing orders (7)
(16, '2026-02-01 10:00:00', 'processing', '579 Magnolia Court, San Francisco, CA 94101', 209.98),
(17, '2026-02-03 12:15:00', 'processing', '680 Dogwood Way, Indianapolis, IN 46201', 79.98),
(18, '2026-02-05 14:30:00', 'processing', '791 Redwood Lane, Seattle, WA 98101', 479.98),
(2, '2026-02-07 09:45:00', 'processing', '456 Oak Avenue, Los Angeles, CA 90001', 34.99),
(4, '2026-02-10 11:00:00', 'processing', '321 Elm Street, Houston, TX 77001', 189.98),
(19, '2026-02-12 16:20:00', 'processing', '802 Palm Street, Denver, CO 80201', 99.98),
(20, '2026-02-15 13:35:00', 'processing', '913 Cypress Blvd, Boston, MA 02101', 129.97),

-- Pending orders (6)
(6, '2026-02-20 08:00:00', 'pending', '987 Cedar Lane, Philadelphia, PA 19101', 174.98),
(8, '2026-02-22 10:30:00', 'pending', '258 Walnut Way, San Diego, CA 92101', 54.99),
(10, '2026-02-24 14:45:00', 'pending', '741 Willow Path, San Jose, CA 95101', 299.99),
(12, '2026-02-26 09:15:00', 'pending', '963 Cherry Lane, Jacksonville, FL 32201', 89.97),
(14, '2026-02-27 11:30:00', 'pending', '357 Poplar Avenue, Columbus, OH 43201', 234.98),
(16, '2026-02-28 15:00:00', 'pending', '579 Magnolia Court, San Francisco, CA 94101', 59.99),

-- Cancelled orders (4)
(7, '2026-01-02 10:00:00', 'cancelled', '147 Birch Court, San Antonio, TX 78201', 149.99),
(9, '2026-01-25 12:30:00', 'cancelled', '369 Spruce Blvd, Dallas, TX 75201', 299.99),
(11, '2026-02-08 14:15:00', 'cancelled', '852 Ash Street, Austin, TX 78701', 179.99),
(13, '2026-02-18 09:45:00', 'cancelled', '159 Hickory Drive, Fort Worth, TX 76101', 44.99);

-- =============================================================================
-- INSERT ORDER_ITEMS (55 order items)
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

-- Order 17: Wireless Headphones
(17, 1, 1, 149.99),

-- Order 18: Monitor Stand
(18, 8, 1, 44.99),

-- Order 19: Webcam + Wireless Mouse + Cable Management
(19, 6, 1, 59.99),
(19, 5, 1, 29.99),
(19, 9, 1, 19.99),

-- Order 20: Power Bank + USB-C Hub
(20, 3, 1, 39.99),
(20, 2, 1, 49.99),

-- Order 21: Ergonomic Office Chair + Standing Desk Converter
(21, 10, 1, 299.99),
(21, 11, 1, 179.99),

-- Order 22: LED Desk Lamp
(22, 7, 1, 34.99),

-- Order 23: Wireless Headphones + USB-C Hub + Power Bank
(23, 1, 1, 149.99),
(23, 2, 1, 49.99),
(23, 3, 1, 39.99),

-- Order 24: Notebook Set x2 + Sticky Notes
(24, 13, 2, 18.99),
(24, 15, 1, 12.99),

-- Order 25: Keyboard Tray + Monitor Stand + Cable Management
(25, 12, 1, 54.99),
(25, 8, 1, 44.99),
(25, 9, 1, 19.99),

-- Order 26: Webcam + Laptop Sleeve
(26, 6, 1, 59.99),
(26, 4, 1, 24.99),

-- Order 27: Ergonomic Office Chair
(27, 10, 1, 299.99),

-- Order 28: Wireless Headphones + Desk Organizer
(28, 1, 1, 149.99),
(28, 14, 1, 22.99),

-- Order 29: Keyboard Tray
(29, 12, 1, 54.99),

-- Order 30: Ergonomic Office Chair
(30, 10, 1, 299.99),

-- Order 31: Notebook Set x3 + Desk Organizer + Sticky Notes x2
(31, 13, 3, 18.99),
(31, 14, 1, 22.99),
(31, 15, 2, 12.99),

-- Order 32: Standing Desk Converter + Keyboard Tray
(32, 11, 1, 179.99),
(32, 12, 1, 54.99),

-- Order 33: Webcam
(33, 6, 1, 59.99),

-- Cancelled orders (34-35) - still have items
(34, 1, 1, 149.99),
(35, 10, 1, 299.99);
