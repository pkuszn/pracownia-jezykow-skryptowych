from db import OrderDatabase
from models import Order
from datetime import datetime
import setup

def main():
    # select()
    add()
    # select_one()

def add():
    order = Order(
        id=None,
        name="Patryk", 
        dish_name="marchewki 2",
        price=40,
        special_requests=None,
        quantity=1,
        created_date=None, 
        delivery_address=None, 
        preparation_time=0.3,
    )

    db = OrderDatabase(setup.db_path)
    db.insert_order(order)

def select():
    db = OrderDatabase(setup.db_path)
    values = db.get_all_orders()
    for val in values:
        print(val)
        
def select_one():
    name = "Patryk"
    db = OrderDatabase(setup.db_path)
    value = db.get_order_by_name(name)
    print(value)
    
if __name__ == "__main__":
    main()