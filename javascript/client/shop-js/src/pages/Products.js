import React, { useEffect, useState } from "react";
import List from "../components/Products/List";
import {
    fetchProductByCategory,
    fetchProducts,
} from "../services/productService.js";

const Products = ({ category }) => {
    const [products, setProducts] = useState([]);

    useEffect(() => {
        if (category) {
            fetchProductByCategory()
                .then((res) => {
                    setProducts(res);
                })
                .catch((err) => {
                    setProducts([]);
                });
        } else {
            fetchProducts()
                .then((res) => {
                    setProducts(res);
                })
                .catch((err) => {
                    setProducts([]);
                });
        }
    }, [category]);

    return (
        <div>
            <List products={products}></List>
        </div>
    );
};

export default Products;
