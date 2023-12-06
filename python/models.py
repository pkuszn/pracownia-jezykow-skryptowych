from models import (
    _MENU_NAME,
    _MENU_PRICE,
    _MENU_PREPARATION_TIME,
)

class RestaurantMenu:
    def __init__(
        self,
        menu
    ):
        self.menu = menu
        
    def menu_as_string(
        self,
        dishes
    ) -> str:
        text = ""
        for index, item in enumerate(dishes, start=1):
            text += f'Position {index} Dish: {item[_MENU_NAME]} Price: {item[_MENU_PRICE]} Preparation time: {item[_MENU_PREPARATION_TIME]}' 
        return text.strip()
    
    def get_item_by_dish(
        self, 
        dish_name
    ) -> dict:
        for item in self.menu:
            if item[self._MENU_NAME].lower() == dish_name.lower():
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
