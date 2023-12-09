from datetime import datetime
import json
import setup
from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from models import Order, RestaurantMenu
from const import (
    _ITEMS,
    _TEXT,
    _OPEN,
    _CLOSE,
    _MENU_NAME,
    _MENU_PRICE,
    _MENU_PREPARATION_TIME,
    _USER_INFO_NAME,
    _DELIVERY_TYPE_HOME,
    _DELIVERY_TYPE_RESTAURANT,
    _PLACE_ORDER_ORDER_TYPE,
    _PLACE_ORDER_DELIVERY_ADDRESS,
    _PLACE_ORDER_QUANTITY,
    _PLACE_ORDER_SPECIAL_REQUEST,
    _PLACE_ORDER_DISH,
    _SLOT_USER_NAME,
    _SLOT_DELIVERY_ADDRESS,
    _SLOT_QUANTITY,
    _SLOT_DISH,
    _SLOT_SPECIAL_REQUEST,
    _SLOT_DATE,
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
            current_day = current_date.strftime("%A").lower()
            current_time = current_date.strftime("%H:%M")
            message = ""
            with open(
                setup.menu_file_path,
                "r", 
                encoding="utf-8"
            ) as file:
                opening_hours=json.load(file)
                day = tracker.get_slot(_SLOT_DAY)
                
                if current_day in opening_hours[_ITEMS]:
                    close_open = opening_hours[_ITEMS][day]
                    
                    if close_open[_OPEN] <= current_time <= close_open[_CLOSE]:
                        message = 'The restaurant is open'
                    else:
                        message = "The restaurant is closed now. It opens at {} and closes at {} on {}.".format(
                            close_open[_OPEN], close_open[_CLOSE], current_day.capitalize()
                        )
                else:
                    message = "Sorry, I don't have information about the opening hours for {}.".format(current_day.capitalize()) 
            dispatcher.utter_message(text="Sorry. I don't have information about opening hours because of technical problems.")       
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
            
            
            if not quantity or not dish_name:
                message = "Sorry, I couldn't retrieve the necessary information to place the order."
                return []
            
            item = None
            with open(
                setup.menu_file_path,
                "r", 
                encoding="utf-8"
            ) as file:
                
                menu=json.load(file)
                restaurant_menu = RestaurantMenu(menu)
                
                item = restaurant_menu.get_item_by_dish(dish_name)
                
                if item is None:
                    message = "Sorry, we couldn't find any dish with the name '{dish_name}'. Please check the menu and try again"
                    dispatcher.utter_message(text=message)
                    return []

            current = datetime.now()
            
            order = Order(
                id=None,
                name=tracker.get_slot(_USER_INFO_NAME), 
                dish_name=dish_name,
                price=item[_MENU_PRICE],
                special_requests=special_request,
                quantity=quantity,
                created_date=current, 
                delivery_address=tracker.get_slot(_PLACE_ORDER_ORDER_TYPE), 
                preparation_time=item[_MENU_PREPARATION_TIME],
            )
            
            db = OrderDatabase(setup.db_path)
            db.insert_order(order)
            
            message = "Your order has been successfully added to our system. We're preparing it for you now. We'll keep you updated on the progress. Thank you for choosing us!"
            
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
                order_date = datetime.strptime(order.created_date, "%Y-%m-%d %H:%M:%S")
                expected_preparation_time = order_date + datetime.timedelta(hours=int(order.preparation_time))
                current_time = datetime.now()
                if current_time >= expected_preparation_time:
                    if order.delivery_type == _DELIVERY_TYPE_HOME:
                        message = f"The meal is ready and will be sent on address {order.delivery_address}. Enjoy your meal!"
                    else:
                        message = "The meal is ready. Enjoy your meal!"
                else:
                    message = "Apologies, your meal isn't ready. We'll keep you updated on your order"
            else:
                message = "It looks like you haven't placed any orders yet. If you'd like to explore our menu or place an order, feel free to let me know!"
        else:
            message = "I'm sorry, but I don't have your name yet. Could you please tell me your name?"

        dispatcher.utter_message(text=message)
        
        return []