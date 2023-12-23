import React, { useState } from "react";
// import CartItem from './CartItem';
import "./style.css";

const Cart = () => {
    const [cartItems, setCartItems] = useState([]);

    const getTotalPrice = () => {
        return cartItems.reduce(
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

    return (
        <div className="cart-container">
            <h2>Shopping Cart</h2>
            {/* {cartItems.map((item) => (
        <CartItem product={item}/>
      ))} */}
            {cartItems.length === 0 && <p>Your cart is empty.</p>}
            <p className="cart-total">Total Price: ${getTotalPrice()}</p>
            <div className="cart-submit">
                <button className="clear-cart-button submit-buttons" onClick={handleClearCart}>
                    Clear Cart
                </button>
                <button className="submit-buttons" onClick={handleClearCart}>
                    Buy
                </button>
            </div>
        </div>
    );
};

export default Cart;
