import React, { useState } from 'react';
import { useCart } from './CartContext';
import { useNavigate } from 'react-router-dom';
import Header from './Header';

const Checkout = () => {
  const { cart, clearCart } = useCart();
  const [customerFirstName, setCustomerFirstName] = useState('');
  const [customerLastName, setCustomerLastName] = useState('');
  const [customerEmail, setCustomerEmail] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();

    const totalAmount = cart.reduce((acc, item) => acc + item.price * item.quantity, 0);

    const order = {
      customer_first_name: customerFirstName,
      customer_last_name: customerLastName,
      customer_email: customerEmail,
      total: totalAmount,
      order_items_attributes: cart.map(item => ({
        product_id: item.id,
        quantity: item.quantity,
        price: item.price,
      })),
    };

    fetch('/api/v1/orders', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(order),
    })
      .then(response => {
        if (response.ok) {
          clearCart();
          navigate('/confirmation');
        } else {
          return response.json().then(err => {
            setError(err.errors ? err.errors.join(', ') : 'An error occurred.');
          });
        }
      })
      .catch(error => setError(error.message));
  };


  const totalAmount = cart.reduce((acc, item) => acc + item.price * item.quantity, 0);

  return (
    <>
      <Header />
      <div style={styles.container}>
        <h2 style={styles.heading}>Checkout</h2>
        {error && <div style={styles.error}>{error}</div>}
        <div style={styles.summary}>
          <h3 style={styles.summaryHeading}>Order Summary</h3>
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
                  </li>
                ))}
              </ul>
              <div style={styles.total}>
                <strong>Total: ${totalAmount.toFixed(2)}</strong>
              </div>
            </div>
          )}
        </div>
        <form onSubmit={handleSubmit} style={styles.form}>
          <div style={styles.formGroup}>
            <label htmlFor="first-name" style={styles.label}>First Name</label>
            <input
              id="first-name"
              type="text"
              style={styles.input}
              value={customerFirstName}
              onChange={(e) => setCustomerFirstName(e.target.value)}
              required
            />
          </div>
          <div style={styles.formGroup}>
            <label htmlFor="last-name" style={styles.label}>Last Name</label>
            <input
              id="last-name"
              type="text"
              style={styles.input}
              value={customerLastName}
              onChange={(e) => setCustomerLastName(e.target.value)}
              required
            />
          </div>
          <div style={styles.formGroup}>
            <label htmlFor="email" style={styles.label}>Email</label>
            <input
              id="email"
              type="email"
              style={styles.input}
              value={customerEmail}
              onChange={(e) => setCustomerEmail(e.target.value)}
              required
            />
          </div>
          <button type="submit" style={styles.button}>Place Order</button>
        </form>
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
  error: {
    color: 'red',
    marginBottom: '20px',
    textAlign: 'center',
  },
  summary: {
    marginBottom: '20px',
  },
  summaryHeading: {
    fontSize: '1.5rem',
    marginBottom: '10px',
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
    padding: '10px 0',
    borderBottom: '1px solid #ddd',
  },
  total: {
    fontSize: '1.2rem',
    fontWeight: 'bold',
    textAlign: 'right',
    marginTop: '10px',
  },
  form: {
    display: 'flex',
    flexDirection: 'column',
  },
  formGroup: {
    marginBottom: '15px',
  },
  label: {
    display: 'block',
    marginBottom: '5px',
    fontWeight: 'bold',
  },
  input: {
    width: '100%',
    padding: '10px',
    border: '1px solid #ddd',
    borderRadius: '5px',
  },
  button: {
    padding: '10px 20px',
    border: 'none',
    borderRadius: '5px',
    backgroundColor: '#007bff',
    color: 'white',
    fontSize: '1rem',
    cursor: 'pointer',
    marginTop: '10px',
  },
};

export default Checkout;
