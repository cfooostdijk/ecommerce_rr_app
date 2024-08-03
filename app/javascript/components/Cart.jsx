import React from 'react';
import { useCart } from './CartContext';
import { Link, useNavigate } from 'react-router-dom';
import Header from './Header';

const Cart = () => {
  const { cart, removeFromCart } = useCart();
  const navigate = useNavigate();

  const handleCheckout = () => {
    navigate('/checkout');
  };

  return (
    <>
      <Header />
      <div style={styles.container}>
        <h2 style={styles.heading}>Shopping Cart</h2>
        {cart.length === 0 ? (
          <p style={styles.emptyMessage}>Your cart is empty.</p>
        ) : (
          <div>
            <ul style={styles.cartList}>
              {cart.map(item => (
                <li key={item.id} style={styles.cartItem}>
                  <div>
                    <strong>{item.title}</strong> - ${item.price} x {item.quantity}
                  </div>
                  <button
                    onClick={() => removeFromCart(item.id)}
                    style={styles.removeButton}
                  >
                    Remove
                  </button>
                </li>
              ))}
            </ul>
            <button onClick={handleCheckout} style={styles.checkoutButton}>
              Checkout
            </button>
          </div>
        )}
        <Link to="/catalog" style={styles.backLink}>Back to catalog</Link>
      </div>
    </>
  );
};

const styles = {
  container: {
    maxWidth: '900px',
    margin: 'auto',
    padding: '20px',
    fontFamily: 'Arial, sans-serif',
  },
  heading: {
    marginBottom: '20px',
    fontSize: '2rem',
    textAlign: 'center',
    color: '#333',
  },
  emptyMessage: {
    textAlign: 'center',
    fontSize: '1.2rem',
    color: '#666',
  },
  cartList: {
    listStyleType: 'none',
    padding: '0',
  },
  cartItem: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '10px',
    borderBottom: '1px solid #ddd',
    marginBottom: '10px',
  },
  removeButton: {
    backgroundColor: '#dc3545',
    color: 'white',
    border: 'none',
    borderRadius: '5px',
    padding: '5px 10px',
    cursor: 'pointer',
    fontSize: '0.9rem',
  },
  checkoutButton: {
    padding: '10px 20px',
    border: 'none',
    borderRadius: '5px',
    backgroundColor: '#007bff',
    color: 'white',
    fontSize: '1rem',
    cursor: 'pointer',
    marginTop: '20px',
    display: 'block',
    margin: 'auto',
  },
  backLink: {
    display: 'block',
    textAlign: 'center',
    marginTop: '20px',
    color: '#007bff',
    textDecoration: 'none',
    fontSize: '1rem',
  },
};

export default Cart;
