import React from 'react'
import './style.css'

export const Form = () => {
  return (
    <div className='login-container'>
        <form className='login-form'>
            <h2>Login</h2>
            <label for='username'>Username</label>
            <input type='text' id='username' placeholder='Enter username'/>
            <label for='password'>Password</label>
            <input type='text'  id='password' placeholder='Enter password'/>
            <button type='submit'>Login</button>
        </form>
    </div>
  )
}

export default Form