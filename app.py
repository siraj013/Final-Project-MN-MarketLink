from flask import Flask, render_template, request, redirect
import mysql.connector

app = Flask(__name__)

# Database connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="yourpassword",  # <-- Replace with your MySQL password
    database="mn_marketlink"
)

cursor = db.cursor(dictionary=True)


# ------------------------------
# ROUTES
# ------------------------------

@app.route("/")
def home():
    return redirect("/markets")


# Browse all markets
@app.route("/markets")
def markets():
    cursor.execute("SELECT * FROM Market")
    markets = cursor.fetchall()
    return render_template("markets.html", markets=markets)


# Market details (with vendors + products)
@app.route("/markets/<int:market_id>")
def market_details(market_id):
    cursor.execute("SELECT * FROM Market WHERE market_id=%s", (market_id,))
    market = cursor.fetchone()

    cursor.execute("""
        SELECT Vendor.vendor_name, Product.*
        FROM Vendor
        JOIN Product ON Vendor.vendor_id = Product.vendor_id
        WHERE Vendor.market_id = %s
    """, (market_id,))
    products = cursor.fetchall()

    return render_template("market_details.html", market=market, products=products)


# Product search
@app.route("/search")
def search():
    q = request.args.get("q", "")

    cursor.execute("""
        SELECT Product.*, Vendor.vendor_name, Market.market_name
        FROM Product
        JOIN Vendor ON Product.vendor_id = Vendor.vendor_id
        JOIN Market ON Vendor.market_id = Market.market_id
        WHERE Product.product_name LIKE %s
    """, ("%" + q + "%",))

    results = cursor.fetchall()
    return render_template("search.html", results=results, q=q)


# Place an order (REQUIRES TRANSACTION)
@app.route("/order", methods=["POST"])
def place_order():
    customer_id = request.form["customer_id"]
    product_id = request.form["product_id"]
    quantity = int(request.form["quantity"])

    try:
        db.start_transaction()

        cursor.execute("""
            INSERT INTO Orders (customer_id, order_date)
            VALUES (%s, NOW())
        """, (customer_id,))
        order_id = cursor.lastrowid

        cursor.execute("""
            INSERT INTO OrderItem (order_id, product_id, quantity)
            VALUES (%s, %s, %s)
        """, (order_id, product_id, quantity))

        db.commit()
        return redirect("/order-success")

    except Exception as e:
        print("Transaction Error:", e)
        db.rollback()
        return "Error: Order transaction failed"


@app.route("/order-success")
def order_success():
    return render_template("order_success.html")


# Run the server
if __name__ == "__main__":
    app.run(debug=True)
