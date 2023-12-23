import React from 'react'
import './style.css'
import Dropdown from './Dropdown'

const Logo = () => {
  return (
    <div id='topbar'>
        <h3>Tea shop</h3>
        <div id='navigation'>
        <ul>
            <li>
                <Dropdown></Dropdown>
            </li>
            <li>
                <a href='/products'>
                    Products
                </a>
            </li>
            <li>
                <a href='/basket'>
                    Basket
                </a>
            </li>
            <li>
                <a href='/login'>
                    Login
                </a>
            </li>
        </ul>
    </div>
    </div>
  )
}

export default Logo