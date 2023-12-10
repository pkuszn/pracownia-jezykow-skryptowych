from datetime import datetime, timedelta
from io import StringIO
import json
import setup
from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from models import Order, RestaurantMenu
from const import (
    _ITEMS,
    _OPEN,
    _CLOSE,
    _MENU_PRICE,
    _MENU_PREPARATION_TIME,
    _USER_INFO_NAME,
    _SLOT_USER_NAME,
    _SLOT_DELIVERY_ADDRESS,
    _SLOT_QUANTITY,
    _SLOT_DISH,
    _SLOT_SPECIAL_REQUEST,
    _SLOT_DAY,
)
from db import OrderDatabase

class ActionOpenHours(Action):
    def name(self) -> Text:
        return "action_open_hours"

    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any]
    ) -> List[Dict[Text, Any]]:
        try:
            
            current_date = datetime.now()
            current_day = current_date.strftime("%A")
            current_time = current_date.hour
            message = ""
            with open(
                setup.opening_hours_path,
                "r", 
                encoding="utf-8"
            ) as file:
                opening_hours=json.load(file)
                day = tracker.get_slot(_SLOT_DAY)
                
                if day is None and current_day in opening_hours[_ITEMS]:
                    close_open = opening_hours[_ITEMS][current_day]
                    
                    open_time = int(close_open[_OPEN])
                    close_time = int(close_open[_CLOSE])
                    
                    if open_time <= current_time <= close_time:
                        message = 'The restaurant is currently open'
                    else:                            
                        message = "The restaurant is closed now. It opens on {} at {} and closes at {}.".format(
                            current_day.capitalize(), close_open[_OPEN], close_open[_CLOSE]
                        )
                elif day is not None and day in opening_hours[_ITEMS]:
                    close_open = opening_hours[_ITEMS][day]
                    
                    open_time = int(close_open[_OPEN])
                    close_time = int(close_open[_CLOSE])
                    
                    message = "The restaurant is open at {} and closes at {} on {}.".format(
                        close_open[_OPEN], close_open[_CLOSE], day.capitalize()
                    )
                else:
                    message = "Sorry, I don't have information about the opening hours for {}.".format(current_day.capitalize()) 
            dispatcher.utter_message(text=message)       
        except FileNotFoundError:
            dispatcher.utter_message(text=message)
        return []
    
class ActionListMenu(Action):
    def name(self) -> Text:
        return "action_list_menu"

    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any]
    ) -> List[Dict[Text, Any]]:
        try:
            with open(
                setup.menu_file_path,
                "r", 
                encoding="utf-8"
            ) as file:
                
                menu=json.load(file)
                restaurant_menu = RestaurantMenu(menu)
                dispatcher.utter_message(
                    text=f"Here is the menu:\n{restaurant_menu.menu_as_string()}"
                )
        except FileNotFoundError:
            dispatcher.utter_message(
                text="Sorry - the menu is currently unavailable."
            )
            
        return []     
    
class ActionPlaceOrder(Action):
    def name(self) -> Text:
        return "action_place_order"
    
    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any]
    ) -> List[Dict[Text, Any]]:
        try:
            message = ""
            quantity = tracker.get_slot(_SLOT_QUANTITY)
            dish_name = tracker.get_slot(_SLOT_DISH)
            special_request = tracker.get_slot(_SLOT_SPECIAL_REQUEST)
            user = tracker.get_slot(_SLOT_USER_NAME)
            delivery_address = tracker.get_slot(_SLOT_DELIVERY_ADDRESS)
            
            print(f"quantity {quantity}")
            print(f"dish {dish_name}")
            print(f"special {special_request}")
            print(f"user {user}")
            print(f"delivery addr {delivery_address}")
                        
            if not user:
                dispatcher.utter_message(text="Could you repeat your order and name?")
                return []
            
            if not quantity or not dish_name:
                dispatcher.utter_message(text="Sorry, I couldn't retrieve the necessary information to place the order.")
                return []
            
            print("test")
            
            item = None
            with open(
                setup.menu_file_path,
                "r", 
                encoding="utf-8"
            ) as file:
                
                menu=json.load(file)
                restaurant_menu = RestaurantMenu(menu)
                print(restaurant_menu)
                
                item = restaurant_menu.get_item_by_dish(dish_name)
                print(item)
                if item is None:
                    dispatcher.utter_message(text=f"Sorry, we couldn't find any dish with the name '{dish_name}'. Please check the menu and try again")
                    return []

                print(f"from menu {item}")

            current = datetime.now()
            
            price = int(quantity) * int(item[_MENU_PRICE])   
            preparation_time = item[_MENU_PREPARATION_TIME]     
            order = Order(
                id=None,
                name=user, 
                dish_name=dish_name,
                price=price,
                special_requests=special_request,
                quantity=quantity,
                created_date=current, 
                delivery_address=delivery_address, 
                preparation_time=preparation_time,
            )
            
            db = OrderDatabase(setup.db_path)
            db.insert_order(order)
            
            buffer = StringIO()
            
            buffer.write("Your order has been successfully added to our system. We're preparing it for you now. We'll keep you updated on the progress. Thank you for choosing us!")
            buffer.write(f"\nOrder: \n{order}")
            message = buffer.getvalue()            
            dispatcher.utter_message(text=message)            
        except Exception as e:
            dispatcher.utter_message(text="Oops! It seems we're experiencing some technical issues, and we couldn't add your order to the system. Please try again later, or you can contact our support for assistance. We apologize for the inconvenience.")
            return []
        return []

class ActionMealAvailability(Action):
    def name(self) -> Text:
        return "action_meal_availability"
    
    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any]
    ) -> List[Dict[Text, Any]]:
        user = tracker.get_slot(_USER_INFO_NAME)
        message = ""
        if user:
            db = OrderDatabase(setup.db_path)
            order = db.get_order_by_name(user)
            if order:
                order_date = datetime.fromisoformat(order.created_date)
                expected_preparation_time = order_date + timedelta(minutes=int(order.preparation_time * 60))
                current_time = datetime.now()
                if current_time >= expected_preparation_time:
                    if order.delivery_address is not None:
                        message = f"The meal {order.dish_name} is ready and will be sent on address {order.delivery_address}. Enjoy your meal!"
                    else:
                        message = f"The meal {order.dish_name} is ready. Enjoy your meal!"
                else:
                    diff = int(((expected_preparation_time - current_time).seconds / 60))
                    message = f"Apologies, your meal {order.dish_name} isn't ready. Your meal will be ready in {diff} minutes"
            else:
                message = "It looks like you haven't placed any orders yet. If you'd like to explore our menu or place an order, feel free to let me know!"
        else:
            message = "I'm sorry, but I don't have your name yet. Could you please tell me your name?"

        dispatcher.utter_message(text=message)
        
        return []

class ActionUserInfo(Action):
    def name (self) -> Text:
        return "action_user_info"
    
    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any],
    ) -> List[Dict[Text, Any]]:
        
        user_name = tracker.get_slot("user_name")
        
        print(user_name)
        
        dispatcher.utter_message(f"Your user_name is  {user_name}")
        
        return []