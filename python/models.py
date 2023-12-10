from io import StringIO
from const import (
    _MENU_NAME,
    _MENU_PRICE,
    _MENU_PREPARATION_TIME,
    _ITEMS,
)

class RestaurantMenu:
    def __init__(
        self,
        menu
    ):
        self.menu = menu
        
    def menu_as_string(
        self,
    ) -> str:
        buffer = StringIO()
        positions = self.menu[_ITEMS]
        for index, item in enumerate(positions):
            buffer.write(f'Position {index} \t Dish: {item[_MENU_NAME]} \t Price: {item[_MENU_PRICE]}$ \t Preparation time: {to_minutes(item[_MENU_PREPARATION_TIME])}min\n')
        return buffer.getvalue()
    
    def get_item_by_dish(
        self, 
        dish_name
    ) -> dict:
        for item in self.menu[_ITEMS]:
            if item[_MENU_NAME].lower() == dish_name.lower():
                return item
        return None
    
class Order:
    id: int
    name: str
    dish_name: str
    price: str
    special_requests: str
    quantity: int
    created_date: str
    delivery_address: str
    preparation_time: int
    delivery_type: str

    def __init__(self, id, name, dish_name, price, special_requests, quantity, created_date, delivery_address, preparation_time):
        self.id = id
        self.name = name
        self.dish_name = dish_name
        self.price = price
        self.special_requests = special_requests
        self.quantity = quantity
        self.created_date = created_date
        self.delivery_address = delivery_address
        self.preparation_time = preparation_time
        
    def __str__(self):
        return (
            f"Order ID: {self.id}\n"
            f"Name: {self.name}\n"
            f"Dish Name: {self.dish_name}\n"
            f"Price: {self.price}\n"
            f"Special Requests: {self.special_requests}\n"
            f"Quantity: {self.quantity}\n"
            f"Created Date: {self.created_date}\n"
            f"Delivery Address: {self.delivery_address}\n"
            f"Preparation Time: {to_minutes(self.preparation_time)} minutes\n"
        )
        
@staticmethod
def to_minutes(
    hours
) -> int:
    return int(hours * 60)