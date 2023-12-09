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
        self,ha
    ) -> str:
        buffer = StringIO()
        positions = self.menu[_ITEMS]
        for index, item in enumerate(positions):
            buffer.write(f'Position {index} \t Dish: {item[_MENU_NAME]} \t Price: {item[_MENU_PRICE]}$ \t Preparation time: {self._to_minutes(item[_MENU_PREPARATION_TIME])}min\n')
        return buffer.getvalue()
    
    def get_item_by_dish(
        self, 
        dish_name
    ) -> dict:
        for item in self.menu:
            if item[self._MENU_NAME].lower() == dish_name.lower():
                return item
        return None
    
    def _to_minutes(
        self,
        hours
    ) -> float:
        return hours * 60
    
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
