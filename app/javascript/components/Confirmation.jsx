import React from 'react';
import { Link } from "react-router-dom";
import Header from './Header';

const Confirmation = () => {
  return (
    <>
      <Header />
      <div style={styles.container}>
        <h2 style={styles.heading}>Order Confirmation</h2>
        <p style={styles.message}>Your order has been placed successfully.</p>
        <Link to="/" style={styles.link}>Go back to home</Link>
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
    textAlign: 'center',
  },
  heading: {
    marginBottom: '20px',
    fontSize: '2rem',
    color: '#333',
  },
  message: {
    marginBottom: '20px',
    fontSize: '1.2rem',
    color: '#555',
  },
  link: {
    display: 'inline-block',
    padding: '10px 20px',
    border: 'none',
    borderRadius: '5px',
    backgroundColor: '#007bff',
    color: 'white',
    fontSize: '1rem',
    textDecoration: 'none',
    cursor: 'pointer',
    marginTop: '10px',
  },
};

export default Confirmation;
