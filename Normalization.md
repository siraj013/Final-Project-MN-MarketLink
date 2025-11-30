 # MN MarketLink – Normalization (3NF)

This document explains how the MN MarketLink schema—based on the ERD—achieves First, Second, and Third Normal Form.

---

# 1. First Normal Form (1NF)

A table is in 1NF when:

- All attributes are atomic
- There are no repeating groups
- Each record is unique

### ✔ How the schema satisfies 1NF
- All fields (Name, Email, Price, Category, etc.) are single-valued.
- Market, Vendor, Product, Customer, Order, OrderItem, and Transaction all have primary keys.
- No multivalued attributes like multiple emails or multiple product prices.

---

# 2. Second Normal Form (2NF)

A table is in 2NF when:

- It is in 1NF
- Every non-key attribute depends on the whole primary key

### ✔ All main entities (Market, Vendor, Product, Customer, Order, Transaction)  
These use single-column primary keys → 2NF is automatically satisfied.

### ✔ OrderItems (only table with composite logic)
- Quantity and ItemPrice depend on the *combination* of Product and Order.
- No partial dependency exists.

OrderItems is fully 2NF.

---

# 3. Third Normal Form (3NF)

A table is in 3NF when:

- It is in 2NF
- There are no transitive dependencies (non-key fields must not depend on other non-key fields)

### ✔ MARKET  
Name, Location, Date all depend *only* on MarketID.

### ✔ VENDOR  
Name and ContactInfo depend only on VendorID.  
MarketID is a foreign key, not a transitive dependency.

### ✔ PRODUCT  
Name, Price, Category depend only on ProductID.  
Vendor info is stored in Vendors → no transitive dependency.

### ✔ CUSTOMER  
Name, Email, Phone depend solely on CustomerID.

### ✔ ORDER  
OrderDate and TotalAmount depend only on OrderID.  
CustomerID and MarketID correctly reference their parent tables.

### ✔ ORDERITEMS  
Quantity and ItemPrice belong to the Order–Product relationship and do not depend on any other non-key field.

### ✔ TRANSACTION  
Amount, PaymentMethod depend only on TransactionID.  
Order-specific information stays in Orders.

---

# ✔ Summary: Schema is Fully 3NF

- Each table represents one concept (Market, Vendor, Product, Customer, Order…).  
- All attributes depend on their table’s primary key.  
- Foreign keys eliminate transitive dependencies.  
- Many-to-many relationships are resolved through the OrderItems table.

The ERD and resulting schema cleanly satisfy **Third Normal Form (3NF)**.
