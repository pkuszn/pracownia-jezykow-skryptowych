import React, { useState } from "react";
import { paymentTypeMapper, deliveryTypeMapper } from "../../utility/utils";


const Details = ({ user, deliveryTypes, paymentTypes, totalPrice, selectPaymentType, selectDeliveryType }) => {
    const [paymentTypeOption, setPaymentTypeOption] = useState("null");
    const [deliveryTypeOption, setDeliveryTypeOption] = useState("null");

    const handlePaymentTypeOption = (event) => {
        setPaymentTypeOption(event.target.value);
        selectPaymentType(paymentTypeMapper(event.target.value))
    };

    const handleDeliveryTypeOption = (event) => {
        setDeliveryTypeOption(event.target.value);
        selectDeliveryType(deliveryTypeMapper(event.target.value));
    }

    return (
        <div className="cart-details">
            <div style={{ width: "48%" }}>
                <h2>User Details</h2>
                <div>
                    <label>Name:</label>
                    <p>
                        <b>{user.name}</b>
                    </p>
                </div>

                <div>
                    <label>Surname:</label>
                    <p>
                        <b>{user.surname}</b>
                    </p>
                </div>

                <div>
                    <label>Address:</label>
                    <p>
                        <b>{user.address}</b>
                    </p>
                </div>
                <div>
                    <label>Selected payment method</label>
                    <p>
                        <b>{paymentTypeOption}</b>
                    </p>
                </div>

                <div>
                    <label>Selected delivery type:</label>
                    <p>
                        <b>{deliveryTypeOption}</b>
                    </p>
                </div>
                <div>
                    <label>Total price:</label>
                    <p>
                        <b>{totalPrice}</b>
                    </p>
                </div>
            </div>
            <div style={{ width: "48%" }}>
                <h2>Payment and Delivery</h2>
                <div>
                    <label htmlFor="paymentMethod">Payment Method:</label>
                    <select
                        id="selectOptions"
                        value={paymentTypeOption}
                        onChange={handlePaymentTypeOption}
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
                        value={deliveryTypeOption}
                        onChange={handleDeliveryTypeOption}
                    >
                        <option value="">Select Delivery Type</option>
                        {deliveryTypes.map((option) => (
                            <option key={option.id} value={option.name}>
                                {option.name}
                            </option>
                        ))}
                    </select>
                </div>
                <div>
                    <label htmlFor="update-address">Update address</label>
                    <input type="text" id="update-address" ></input>
                </div>
            </div>
        </div>
    );
};

export default Details;
