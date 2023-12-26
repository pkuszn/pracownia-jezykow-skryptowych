import React, { useEffect, useState } from "react";
import "./style.css";
import { useBasket } from "../../contexts/BasketContext";
import CartItem from "./CartItem.js";
import { fetchUser } from "../../services/userService.js";
import { fetchDeliveryType} from "../../services/deliveryTypeService.js";
import { fetchPaymentTypes } from "../../services/paymentTypeService.js";
import { makeOrder } from "../../services/purchaseService.js";
import { User } from "../../models/user.js";
import Details from "./Details.js";

const Cart = () => {
    const [cartItems, setCartItems] = useState([]);
    const { state } = useBasket();
    const [user, setUser] = useState(new User(1, 'root', 'root', 'root', 'Zabrze', '2023-12-22T20:44:42Z'));
    const [deliveryTypes, setDeliveryTypes] = useState([]);
    const [paymentTypes, setPaymentTypes] = useState([]);

    const getTotalPrice = () => {
        return state.items.reduce(
            (total, item) => total + item.price * item.quantity,
            0
        );
    };

    const handleRemoveItem = (itemId) => {
        const updatedCart = cartItems.filter((item) => item.id !== itemId);
        setCartItems(updatedCart);
    };

    const handleClearCart = () => {
        setCartItems([]);
    };

    const handleBuy = () => {
        return null;
    };

    const getUserName = () => {
        return sessionStorage.getItem("usename");
    }

    useEffect(() => {
        // fetchUser(getUserName())
        //     .then((res) => {
        //         setUser(res);
        //     })
        //     .catch((err) => {
        //         setUser({});
        //     })
        fetchDeliveryType()
            .then((res) => {
                setDeliveryTypes(res);
            })
            .catch((err) => {
                setDeliveryTypes([]);
            })

        fetchPaymentTypes()
            .then((res) => {
                setPaymentTypes(res);
            })
            .catch((err) => {
                setPaymentTypes([]);
            })
    }, []);

    //TODO: FIX!!!
    return (
        <div className="cart-container">
            <h2>Shopping Cart</h2>
            {state.items.map((item) => (
                <CartItem product={item} />
            ))}
            {cartItems.length === 0 && <p>Your cart is empty.</p>}
            <p className="cart-total">Total Price: ${getTotalPrice()}</p>
            <Details user={user}>

            </Details>
            <div className="cart-submit">
                <button
                    className="clear-cart-button submit-buttons"
                    onClick={handleClearCart}
                >
                    Clear Cart
                </button>
                <button className="submit-buttons" onClick={handleBuy}>
                    Buy
                </button>
            </div>
        </div>
    );
};

export default Cart;
