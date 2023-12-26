import React from "react";
import "./style.css";
import { checkUser } from "../../services/userService";

export const Form = () => {
    //TODO: Fix!
    const userHandler = () => {
        let user = document.getElementById("username");
        let password = document.getElementById("password");

        let userExists = checkUser(user, password);
        if (userExists) {
            sessionStorage.setItem('username', user.value);
        } else {
            alert("User doesn't exists");
        }
    };

    return (
        <div className="login-container">
            <form className="login-form">
                <h2>Login</h2>
                <label for="username">Username</label>
                <input type="text" id="username" placeholder="Enter username" />
                <label for="password">Password</label>
                <input type="text" id="password" placeholder="Enter password" />
                <button type="submit" onClick={userHandler}>Login</button>
            </form>
        </div>
    );
};

export default Form;
