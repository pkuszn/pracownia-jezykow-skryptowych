import React from "react";

const Details = ({ user, deliveryTypes, paymentTypes}) => {
    const handleItemClick = (value) => {
        console.log(`Item clicked: ${value}`);
    };
    //TODO: FIX!!!
    return (
        <div
            style={{
                display: "flex",
                justifyContent: "space-between",
                width: "600px",
            }}
        >
            <div style={{ width: "48%" }}>
                <h2>User Details</h2>
                <div>
                    <label htmlFor="firstName">Name:</label>
                    <p>
                        <b>{user.name}</b>
                    </p>
                </div>

                <div>
                    <label htmlFor="lastName">Surname:</label>
                    <p>
                        <b>{user.surname}</b>
                    </p>
                </div>

                <div>
                    <label htmlFor="age">Address:</label>
                    <p>
                        <b>{user.address}</b>
                    </p>
                </div>
            </div>

            <div style={{ width: "48%" }}>
                <h2>Payment and Delivery</h2>
                <div>
                    <label htmlFor="paymentMethod">Payment Method:</label>
                    <select id="paymentMethod" name="paymentMethod">
                        <option value="">Select Payment Method</option>
                        <option value="creditCard">Credit Card</option>
                        <option value="paypal">PayPal</option>
                    </select>
                </div>

                <div>
                    <label htmlFor="deliveryMethod">Delivery Method:</label>
                    <select id="deliveryMethod" name="deliveryMethod">
                        {deliveryTypes.map((option) => (
                            <li
                                key={option.name}
                                onClick={() => handleItemClick(option.id)}
                            >
                                {option.name}
                            </li>
                        ))}
                    </select>
                </div>
            </div>
        </div>
    );
};

export default Details;
