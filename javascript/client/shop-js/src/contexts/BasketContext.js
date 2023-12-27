import React, { createContext, useContext, useReducer } from 'react';

const initialState = {
  items: [],
};

const BasketContext = createContext(); 

const basketReducer = (state, action) => {
  switch (action.type) {
    case 'ADD_TO_BASKET':
      addToBasket(state.items);
      return {
        ...state,
        items: [...state.items, action.payload],
      };
    // Add more cases for other actions (e.g., remove from basket)
    default:
      return state;
  }
};

const addToBasket = (items) => {
  const basket = JSON.parse(localStorage.getItem('cart')) || [];
  basket.push([...items]);
  localStorage.setItem('cart', JSON.stringify(basket));
}

export const useBasket = () => {
  return useContext(BasketContext);
};

export const BasketProvider = ({ children }) => {
  const [state, dispatch] = useReducer(basketReducer, initialState);

  return (
    <BasketContext.Provider value={{ state, dispatch }}>
      {children}
    </BasketContext.Provider>
  );
};
