import React from "react";
import { categoryMapper } from "../../utility/utils";
import { useBasket } from "../../contexts/BasketContext";
import { PurchaseDto } from "../../dtos/purchaseDto.js";
const Element = ({ product }) => {
    const { dispatch } = useBasket();

    const addToBasketHandler = (product) => {
        let quantity = document.getElementById('product-quantity').value;
        let purchaseDto = new PurchaseDto(product.id, product.name, product.category, product.price, quantity);
        alert(product.id);
        dispatch({ type: "ADD_TO_BASKET", payload: purchaseDto });
    };

    return (
        <div className="product-card">
            <div className="product-details">
                <h2>{product.name}</h2>
                <p>
                    <b>ID:</b> {product.id}
                </p>
                <p>
                    <b>Category:</b> {categoryMapper(product.category)}
                </p>
                <p>
                    <b>Price:</b> ${product.price.toFixed(2)}
                </p>
                <p>
                    <b>Created Date:</b> {product.created_date}
                </p>
                <p className="description">
                    <b>Description:</b> {product.description}
                </p>
            </div>
            <div className="product-card-footer">
                <p>
                    <b>Available:</b> {product.available ? "Yes" : "No"}
                </p>
                {product.available ? (
                    <div className="product-card-add">
                        <div className="product-card-add-quantity">
                            <p className="product-quantity-text">Quantity</p>
                            <input
                                type="text"
                                value="1"
                                id="product-quantity"
                                placeholder="Quantity"
                            ></input>
                        </div>
                        <button
                            className="product-button"
                            onClick={() => addToBasketHandler(product)}
                        >
                            Add to basket
                        </button>
                    </div>
                ) : (
                    ""
                )}
            </div>
        </div>
    );
};

export default Element;
