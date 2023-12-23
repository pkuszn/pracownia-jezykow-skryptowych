import React from 'react'
import { Route, Routes, BrowserRouter } from 'react-router-dom';
import Home from '../pages/Home';
import Basket from '../pages/Basket';
import Login from '../pages/Login';
import Products from '../pages/Products';

const AppRouter = () => {
  return (
    <div className='home'>
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Home/>}/>
                <Route path="/basket" element={<Basket/>}/>
                <Route path="/login" element={<Login/>}/>
                <Route path='/products' element={<Products/>}/>
            </Routes>
        </BrowserRouter>
    </div>
  )
}

export default AppRouter