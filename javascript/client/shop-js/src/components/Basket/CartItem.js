import React from 'react';
import './style.css';

const CartItem = ({product}) => {
  return (
    <div className="cart-item">
      <p>Name: {product.name}</p>
      <p>Price: {product.price}$</p>
      <p>Quantity: {product.quantity}</p>
    </div>
  );
};

export default CartItem;