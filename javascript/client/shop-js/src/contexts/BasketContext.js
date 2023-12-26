import React, { createContext, useContext, useReducer } from 'react';

const initialState = {
  items: [],
};

const BasketContext = createContext(); 

const basketReducer = (state, action) => {
  switch (action.type) {
    case 'ADD_TO_BASKET':
      return {
        ...state,
        items: [...state.items, action.payload],
      };
    // Add more cases for other actions (e.g., remove from basket)
    default:
      return state;
  }
};

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
