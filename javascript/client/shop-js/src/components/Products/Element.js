import React from "react";
import { categoryMapper } from "../../utility/utils";
import { useBasket } from "../../contexts/BasketContext";
const Element = ({ product }) => {
    const { dispatch } = useBasket();

    const addToBasketHandler = (product) => {
        dispatch({ type: "ADD_TO_BASKET", payload: product });
    };

    return (
        <div className="product-card">
            <div className="product-details">
                <h2>{product.name}</h2>
                <p>ID: {product.id}</p>
                <p>Category: {categoryMapper(product.category)}</p>
                <p>Price: ${product.price.toFixed(2)}</p>
                <p>Created Date: {product.created_date}</p>
                <p className="description">
                    Description: {product.description}
                </p>
            </div>
            <div className="product-card-footer">
                <p>Available: {product.available ? "Yes" : "No"}</p>
                <input
                    type="text"
                    value="1"
                    className="product-quantity"
                    placeholder="Quantity"
                ></input>
                {product.available ? (
                    <button
                        className="product-button"
                        onClick={() => addToBasketHandler(product)}
                    >
                        Add to basket
                    </button>
                ) : (
                    <div className="product-button">Add to basket</div>
                )}
            </div>
        </div>
    );
};

export default Element;
