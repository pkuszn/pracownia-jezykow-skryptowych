import React from "react";
import Element from "./Element";
import "./style.css";

const List = ({ products }) => {
    return (
        <div>
            <h1 className="product-header">Product Details</h1>
            <div className="product-list">
                {products.map((product) => (
                    <div ley={product.id} className="product-item">
                        <Element product={product} />
                    </div>
                ))}
            </div>
        </div>
    );
};

export default List;
