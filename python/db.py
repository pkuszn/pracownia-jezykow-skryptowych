import datetime
import sqlite3

from models import Order

class OrderDatabase:
    def __init__(self, db_path):
        self.conn = sqlite3.connect(db_path)

    def insert_order(
        self, 
        order: Order
    ) -> None:
        order.created_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        cursor = self.conn.cursor()
        cursor.execute('''
            INSERT INTO "order" (
                "name", "dish_name", "price", "special_requests",
                "quantity", "created_date", "delivery_address", "preparation_time"
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?);
        ''', (order.name, order.dish_name, order.price, order.special_requests,
              order.quantity, order.created_date, order.delivery_address, order.preparation_time))
        self.conn.commit()

    def get_all_orders(self) -> list[Order]:
        cursor = self.conn.cursor()
        cursor.execute('SELECT * FROM "order";')
        rows = cursor.fetchall()
        return [Order(*row) for row in rows]
    
    def get_order_by_name(
        self, 
        user_name: str
    ) -> Order:
        cursor = self.conn.cursor()
        cursor.execute('SELECT * FROM "order" where "name" == ?', user_name)
        row = cursor.fetchone()[0]
        return Order(*row)