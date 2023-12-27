import React, { useEffect, useState } from "react";
import "./style.css";
import CartItem from "./CartItem.js";
import { fetchUser } from "../../services/userService.js";
import { fetchDeliveryType} from "../../services/deliveryTypeService.js";
import { fetchPaymentType } from "../../services/paymentTypeService.js";
import { makeOrder } from "../../services/purchaseService.js";
import Details from "./Details.js";
import { PurchaseDto } from "../../dtos/purchaseDto.js";

const Cart = () => {
    const [cartItems, setCartItems] = useState([]);
    const [user, setUser] = useState({});
    const [deliveryTypes, setDeliveryTypes] = useState([]);
    const [paymentTypes, setPaymentTypes] = useState([]);
    const [products, setProducts] = useState([]);

    const getTotalPrice = () => {
        return products.reduce(
            (total, item) => total + item.price * item.quantity,
            0
        );
    };

    const purchaseHandler = () => {
        const storedDataString = localStorage.getItem('cart');
        const storedData = storedDataString ? JSON.parse(storedDataString) : [];
        console.log(storedData);
        //TODO
        /*
        id,
        name,
        category,
        price,
        quantity
        */
        let purchases = storedData.map(p => new PurchaseDto(p.id, p.name, p.category, p.price, p.quantity));
        console.log(purchases);
        setProducts(purchases);
    }

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
        return sessionStorage.getItem("username");
    }

    useEffect(() => {
        fetchUser(getUserName())
            .then((res) => {
                setUser(res);
                console.log(res);
            })
            .catch((err) => {
                setUser({});
            })
        fetchDeliveryType()
            .then((res) => {
                setDeliveryTypes(res);
            })
            .catch((err) => {
                setDeliveryTypes([]);
                console.log(err);
            })
        fetchPaymentType()
            .then((res) => {
                setPaymentTypes(res);
                console.log(res);
            })
            .catch((err) => {
                setPaymentTypes([]);
                console.log(err);
            })
        purchaseHandler();
    }, []);

    return (
        <div className="cart-container">
            <h2>Shopping Cart</h2>
            {products.map((item) => (
                <CartItem product={item} />
            ))}
            {cartItems.length === 0 && <p>Your cart is empty.</p>}
            <p className="cart-total">Total Price: ${getTotalPrice()}</p>
            <Details user={user} deliveryTypes={deliveryTypes} paymentTypes={paymentTypes}>

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
