-- ==============================================================
-- MN MarketLink — Sample Data Population Script
-- Inserts: 10 Markets, 20 Vendors, 50 Products + sample orders
-- ==============================================================

-- Clear tables (optional when reseeding)
DELETE FROM Transactions;
DELETE FROM OrderItems;
DELETE FROM Orders;
DELETE FROM Products;
DELETE FROM Vendors;
DELETE FROM Markets;
DELETE FROM Customers;

-- ==============================================================
-- MARKETS (10)
-- ==============================================================

INSERT INTO Markets (Name, Location, Date) VALUES
('St. Paul Farmers Market', 'St. Paul, MN', 'Saturdays'),
('Minneapolis Downtown Market', 'Minneapolis, MN', 'Saturdays & Sundays'),
('Duluth Harbor Market', 'Duluth, MN', 'Fridays'),
('Rochester Fresh Market', 'Rochester, MN', 'Saturdays'),
('Mankato Valley Market', 'Mankato, MN', 'Sundays'),
('Eagan Community Market', 'Eagan, MN', 'Wednesdays'),
('Stillwater River Market', 'Stillwater, MN', 'Saturdays'),
('Bloomington Local Market', 'Bloomington, MN', 'Saturdays'),
('St. Cloud Growers Market', 'St. Cloud, MN', 'Thursdays'),
('Edina Green Market', 'Edina, MN', 'Fridays');

-- ==============================================================
-- VENDORS (20)
-- ==============================================================

INSERT INTO Vendors (Name, ContactInfo, MarketID) VALUES
('Green Acres Farm', 'greenacres@example.com', 1),
('Northern Veggies', 'nveggies@example.com', 1),
('Sweet Honey Co', 'honey@example.com', 2),
('Prairie Meats', 'meats@example.com', 2),
('Bella Herbs', 'herbs@bella.com', 3),
('Sunrise Orchards', 'orchard@sunrise.com', 3),
('Wild Roots Farm', 'wildroots@example.com', 4),
('Timber Creek Dairy', 'dairy@timbercreek.com', 5),
('Riverside Greens', 'greens@riverside.com', 6),
('Frostbite Berries', 'berries@frostbite.com', 7),
('Golden Harvest Grains', 'grains@golden.com', 8),
('Happy Hen Eggs', 'eggs@happyhens.com', 9),
('Red Barn Produce', 'redbarn@example.com', 10),
('Rolling Hills Farm', 'rolling@example.com', 4),
('Cedar Grove Honey', 'cedarhoney@example.com', 8),
('Summit Mushrooms', 'mushrooms@example.com', 6),
('Blue Sky Veggies', 'veggies@bluesky.com', 1),
('Meadowfield Dairy', 'meadow@example.com', 9),
('Green Leaf Organics', 'gleaf@example.com', 7),
('Northern Fields Co', 'nf@example.com', 5);

-- ==============================================================
-- PRODUCTS (50)
-- ==============================================================

INSERT INTO Products (Name, Price, Category, VendorID) VALUES
('Carrots', 2.50, 'Vegetable', 1),
('Potatoes', 3.00, 'Vegetable', 1),
('Beets', 2.75, 'Vegetable', 2),
('Honey Jar', 8.50, 'Honey', 3),
('Beef Steak', 14.00, 'Meat', 4),
('Pork Sausage', 9.00, 'Meat', 4),
('Basil Bunch', 2.00, 'Herb', 5),
('Rosemary Bunch', 2.25, 'Herb', 5),
('Apples', 4.50, 'Fruit', 6),
('Pears', 4.75, 'Fruit', 6),
('Spinach', 3.25, 'Vegetable', 7),
('Kale', 3.00, 'Vegetable', 7),
('Milk (1 Gallon)', 5.00, 'Dairy', 8),
('Cheddar Cheese', 6.50, 'Dairy', 8),
('Lettuce', 2.75, 'Vegetable', 9),
('Cucumber', 1.50, 'Vegetable', 9),
('Strawberries', 6.00, 'Fruit', 10),
('Blueberries', 7.00, 'Fruit', 10),
('Whole Grain Flour', 4.50, 'Grains', 11),
('Oats (1 lb)', 3.25, 'Grains', 11),
('Eggs (Dozen)', 4.00, 'Eggs', 12),
('Duck Eggs (Half Dozen)', 5.50, 'Eggs', 12),
('Tomatoes', 3.50, 'Vegetable', 13),
('Bell Peppers', 3.75, 'Vegetable', 13),
('Peaches', 4.75, 'Fruit', 14),
('Plums', 4.50, 'Fruit', 14),
('Clover Honey', 9.00, 'Honey', 15),
('Wildflower Honey', 10.00, 'Honey', 15),
('Shiitake Mushrooms', 6.00, 'Mushrooms', 16),
('Oyster Mushrooms', 7.00, 'Mushrooms', 16),
('Sweet Corn', 0.75, 'Vegetable', 17),
('Green Beans', 2.50, 'Vegetable', 17),
('Yogurt Cup', 2.25, 'Dairy', 18),
('Butter (Salted)', 4.75, 'Dairy', 18),
('Romaine Lettuce', 2.50, 'Vegetable', 19),
('Zucchini', 1.75, 'Vegetable', 19),
('Ground Beef', 8.75, 'Meat', 20),
('Chicken Breast', 7.50, 'Meat', 20),
('Cherries', 5.25, 'Fruit', 10),
('Raspberries', 6.50, 'Fruit', 10),
('Herbal Tea Mix', 4.00, 'Herb', 5),
('Mint Bunch', 1.75, 'Herb', 5),
('Pumpkin', 4.00, 'Vegetable', 13),
('Onions (3 lb Bag)', 2.50, 'Vegetable', 1),
('Garlic Bulbs', 1.25, 'Vegetable', 7),
('String Cheese', 1.50, 'Dairy', 8),
('Broccoli', 2.75, 'Vegetable', 17),
('Cauliflower', 3.00, 'Vegetable', 17),
('Apple Cider', 5.50, 'Beverage', 6);

-- ==============================================================
-- SAMPLE CUSTOMERS
-- ==============================================================

INSERT INTO Customers (Name, Email, Phone) VALUES
('John Miller', 'john@example.com', '555-1010'),
('Sarah Olson', 'sarah@example.com', '555-2020'),
('Adam Chen', 'adam@example.com', '555-3030');

-- ==============================================================
-- SAMPLE ORDERS
-- ==============================================================

INSERT INTO Orders (OrderDate, TotalAmount, CustomerID, MarketID)
VALUES
(NOW(), 18.00, 1, 1),
(NOW(), 27.50, 2, 2),
(NOW(), 45.25, 3, 3);

-- ==============================================================
-- ORDER ITEMS
-- ==============================================================

INSERT INTO OrderItems (OrderID, ProductID, Quantity, ItemPrice) VALUES
(1, 1, 2, 2.50),
(1, 4, 1, 8.50),
(2, 5, 2, 14.00),
(2, 11, 1, 3.25),
(3, 17, 1, 6.00),
(3, 18, 2, 7.00);

-- ==============================================================
-- TRANSACTIONS
-- ==============================================================

INSERT INTO Transactions (TransactionDate, Amount, PaymentMethod, OrderID)
VALUES
(NOW(), 18.00, 'Card', 1),
(NOW(), 27.50, 'Cash', 2),
(NOW(), 45.25, 'Card', 3);
