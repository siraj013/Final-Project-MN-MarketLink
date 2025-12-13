import sqlite3

db = sqlite3.connect('mn_marketlink.db')
cursor = db.cursor()

# Create tables
cursor.execute('''
CREATE TABLE IF NOT EXISTS Market (
    market_id INTEGER PRIMARY KEY AUTOINCREMENT,
    market_name TEXT NOT NULL,
    location TEXT NOT NULL,
    date TEXT
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Vendor (
    vendor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    vendor_name TEXT NOT NULL,
    contact_info TEXT,
    market_id INTEGER,
    FOREIGN KEY (market_id) REFERENCES Market(market_id)
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT NOT NULL,
    price REAL NOT NULL,
    category TEXT,
    vendor_id INTEGER,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_date TEXT DEFAULT CURRENT_TIMESTAMP,
    total_amount REAL,
    customer_id INTEGER,
    market_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (market_id) REFERENCES Market(market_id)
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS OrderItem (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    item_price REAL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    transaction_date TEXT DEFAULT CURRENT_TIMESTAMP,
    amount REAL,
    payment_method TEXT,
    order_id INTEGER,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
)
''')

# Insert sample data
markets = [
    ('St. Paul Farmers Market', 'St. Paul, MN', 'Saturdays'),
    ('Minneapolis Downtown Market', 'Minneapolis, MN', 'Saturdays & Sundays'),
    ('Duluth Harbor Market', 'Duluth, MN', 'Fridays'),
    ('Rochester Fresh Market', 'Rochester, MN', 'Saturdays'),
]

for name, loc, date in markets:
    cursor.execute("INSERT OR IGNORE INTO Market (market_name, location, date) VALUES (?, ?, ?)", (name, loc, date))

vendors = [
    ('Green Acres Farm', 'greenacres@example.com', 1),
    ('Northern Veggies', 'nveggies@example.com', 1),
    ('Sweet Honey Co', 'honey@example.com', 2),
    ('Prairie Meats', 'meats@example.com', 2),
    ('Bella Herbs', 'herbs@bella.com', 3),
]

for name, contact, mid in vendors:
    cursor.execute("INSERT OR IGNORE INTO Vendor (vendor_name, contact_info, market_id) VALUES (?, ?, ?)", (name, contact, mid))

products = [
    ('Apples', 2.50, 'Fruit', 1),
    ('Carrots', 1.00, 'Vegetable', 2),
    ('Honey', 5.00, 'Sweetener', 3),
    ('Beef', 10.00, 'Meat', 4),
    ('Basil', 3.00, 'Herb', 5),
]

for name, price, cat, vid in products:
    cursor.execute("INSERT OR IGNORE INTO Product (product_name, price, category, vendor_id) VALUES (?, ?, ?, ?)", (name, price, cat, vid))

cursor.execute("INSERT OR IGNORE INTO Customer (name, email, phone) VALUES (?, ?, ?)", ('Demo User', 'demo@example.com', '123-456-7890'))

db.commit()
db.close()

print("Database initialized.")
