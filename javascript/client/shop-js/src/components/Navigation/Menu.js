import React, {useEffect, useState} from "react";
import "./style.css";
import Dropdown from "./Dropdown";

const Logo = () => {
    const [user, setUser] = useState("");
 
    useEffect(() => {
        const username = sessionStorage.getItem("username");
        if (username !== undefined || username !== "") {
            setUser(username);
        }
    }, [])

    const logoutHandler = () => {
        sessionStorage.clear();
        window.location.reload();
    }

    return (
        <div id="topbar">
            <h3>Tea shop</h3>
            <div id="navigation">
                <ul>
                    <li>
                        {user ? "Logged as: " + user : ""}
                    </li>
                    <li>
                        <Dropdown></Dropdown>
                    </li>
                    <li>
                        <a href="/products">Products</a>
                    </li>
                    <li>
                        <a href="/basket">Basket</a>
                    </li>
                    <li>
                        {user ? <p onClick={logoutHandler}><b>Log out</b></p> : <a href="/login">Login</a> }
                    </li>
                </ul>
            </div>
        </div>
    );
};

export default Logo;
