-- ============================================================
-- MN MarketLink Schema (Based strictly on ERD diagram)
-- ============================================================

DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Vendors;
DROP TABLE IF EXISTS Markets;
DROP TABLE IF EXISTS Customers;

-- ============================================================
-- MARKET
-- ============================================================
CREATE TABLE Markets (
    MarketID      SERIAL PRIMARY KEY,
    Name          VARCHAR(255) NOT NULL,
    Location      VARCHAR(255) NOT NULL,
    Date          VARCHAR(100)    -- operating date (from diagram)
);

-- ============================================================
-- VENDOR
-- ============================================================
CREATE TABLE Vendors (
    VendorID     SERIAL PRIMARY KEY,
    Name         VARCHAR(255) NOT NULL,
    ContactInfo  VARCHAR(255),
    MarketID     INT NOT NULL,
    FOREIGN KEY (MarketID) REFERENCES Markets(MarketID)
);

-- ============================================================
-- PRODUCT
-- ============================================================
CREATE TABLE Products (
    ProductID   SERIAL PRIMARY KEY,
    Name        VARCHAR(255) NOT NULL,
    Price       DECIMAL(10,2) NOT NULL,
    Category    VARCHAR(100),
    VendorID    INT NOT NULL,
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID)
);

-- ============================================================
-- CUSTOMER
-- ============================================================
CREATE TABLE Customers (
    CustomerID  SERIAL PRIMARY KEY,
    Name        VARCHAR(255) NOT NULL,
    Email       VARCHAR(255) UNIQUE NOT NULL,
    Phone       VARCHAR(50)
);

-- ============================================================
-- ORDER
-- ============================================================
CREATE TABLE Orders (
    OrderID      SERIAL PRIMARY KEY,
    OrderDate    TIMESTAMP DEFAULT NOW(),
    TotalAmount  DECIMAL(10,2) NOT NULL,

    CustomerID   INT NOT NULL,
    MarketID     INT NOT NULL,

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (MarketID) REFERENCES Markets(MarketID)
);

-- ============================================================
-- ORDER ITEM (needed for M:N between ORDER and PRODUCT)
-- ============================================================
CREATE TABLE OrderItems (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID     INT NOT NULL,
    ProductID   INT NOT NULL,
    Quantity    INT NOT NULL,
    ItemPrice   DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ============================================================
-- TRANSACTION
-- ============================================================
CREATE TABLE Transactions (
    TransactionID   SERIAL PRIMARY KEY,
    TransactionDate TIMESTAMP DEFAULT NOW(),
    Amount          DECIMAL(10,2) NOT NULL,
    PaymentMethod   VARCHAR(50),
    OrderID         INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
