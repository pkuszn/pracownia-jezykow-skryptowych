import React from "react";
import { categoryMapper } from "../../utility/utils";

const Element = ({ product }) => {
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
                    <button class='product-button'>Add to basket</button>
            </div>
        </div>
    );
};

export default Element;
