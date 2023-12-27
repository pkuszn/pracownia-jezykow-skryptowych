import React, { useState } from "react";

const Details = ({user, deliveryTypes, paymentTypes}) => {
    const handleItemClick = (value) => {
        console.log(`Item clicked: ${value}`);
    };

    const [selectedOption, setSelectedOption] = useState("");

    const handleSelectChange = (event) => {
        setSelectedOption(event.target.value);
    };

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
                    <select
                        id="selectOptions"
                        value={selectedOption}
                        onChange={handleSelectChange}
                    >
                        <option value="">Select Payment Method</option>
                        {paymentTypes.map((option) => (
                            <option key={option.id} value={option.name}>
                                {option.name}
                            </option>
                        ))}
                    </select>
                </div>

                <div>
                    <label htmlFor="selectOptions">Select Delivery Type:</label>
                    <select
                        id="selectOptions"
                        value={selectedOption}
                        onChange={handleSelectChange}
                    >
                        <option value="">Select Delivery Type</option>
                        {deliveryTypes.map((option) => (
                            <option key={option.id} value={option.name}>
                                {option.name}
                            </option>
                        ))}
                    </select>
                    {selectedOption && <p>Selected Option: {selectedOption}</p>}
                </div>
            </div>
        </div>
    );
};

export default Details;
