-- ==============================================================
-- MN MarketLink — Application SQL Queries
-- ==============================================================

--------------------------------------------------------------
-- 1. List all markets with vendor counts
--------------------------------------------------------------
SELECT m.Name AS Market,
       m.Location,
       COUNT(v.VendorID) AS VendorCount
FROM Markets m
LEFT JOIN Vendors v ON v.MarketID = m.MarketID
GROUP BY m.MarketID;

-- Purpose: Display markets and the number of farmers at each.

--------------------------------------------------------------
-- 2. Get all vendors for a specific market
--------------------------------------------------------------
SELECT v.VendorID, v.Name, v.ContactInfo
FROM Vendors v
WHERE v.MarketID = 1;

-- Purpose: Used when viewing a market's vendor list.

--------------------------------------------------------------
-- 3. List all products sold at a specific market
--------------------------------------------------------------
SELECT p.ProductID, p.Name, p.Price, p.Category, v.Name AS Vendor
FROM Products p
JOIN Vendors v ON p.VendorID = v.VendorID
WHERE v.MarketID = 1;

-- Purpose: Show all available products for shoppers on a market’s page.

--------------------------------------------------------------
-- 4. Search products by keyword
--------------------------------------------------------------
SELECT ProductID, Name, Price, Category
FROM Products
WHERE LOWER(Name) LIKE LOWER('%apple%');

-- Purpose: Search bar autocomplete / product search.

--------------------------------------------------------------
-- 5. Get full order details for the cart/checkout page
--------------------------------------------------------------
SELECT o.OrderID, o.OrderDate, c.Name AS Customer,
       p.Name AS Product, oi.Quantity, oi.ItemPrice,
       (oi.Quantity * oi.ItemPrice) AS LineTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE o.OrderID = 1;

-- Purpose: Retrieve everything needed to display an order summary.

--------------------------------------------------------------
-- 6. Revenue per Vendor
--------------------------------------------------------------
SELECT v.Name AS Vendor,
       SUM(oi.Quantity * oi.ItemPrice) AS Revenue
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
JOIN Vendors v ON p.VendorID = v.VendorID
GROUP BY v.VendorID
ORDER BY Revenue DESC;

-- Purpose: Vendor revenue analytics dashboard.

--------------------------------------------------------------
-- 7. Total market sales
--------------------------------------------------------------
SELECT m.Name AS Market,
       SUM(t.Amount) AS TotalMarketSales
FROM Transactions t
JOIN Orders o ON t.OrderID = o.OrderID
JOIN Markets m ON o.MarketID = m.MarketID
GROUP BY m.MarketID
ORDER BY TotalMarketSales DESC;

-- Purpose: Market-level admin dashboard stats.

--------------------------------------------------------------
-- 8. Customer purchase history
--------------------------------------------------------------
SELECT o.OrderID, o.OrderDate, o.TotalAmount
FROM Orders o
WHERE o.CustomerID = 1
ORDER BY o.OrderDate DESC;

-- Purpose: Customer profile page → order history.

--------------------------------------------------------------
-- 9. Products sold by a specific vendor
--------------------------------------------------------------
SELECT p.ProductID, p.Name, p.Price, p.Category
FROM Products p
WHERE p.VendorID = 2;

-- Purpose: Vendor detail page.

--------------------------------------------------------------
-- 10. Top-selling products (by quantity)
--------------------------------------------------------------
SELECT p.Name, SUM(oi.Quantity) AS TotalSold
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY TotalSold DESC
LIMIT 10;

-- Purpose: Popular products section for the UI.
