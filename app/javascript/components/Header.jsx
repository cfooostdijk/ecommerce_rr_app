import React from 'react';
import { Link } from 'react-router-dom';
import { useCart } from './CartContext';

const Header = () => {
  const { cart } = useCart();

  const totalItems = Array.isArray(cart)
    ? cart.reduce((acc, item) => acc + (item.quantity || 0), 0)
    : 0;

  return (
    <header style={styles.header} className="d-flex justify-content-between align-items-center p-3 bg-light border-bottom">
      <Link to="/" style={styles.logo} className="text-decoration-none">
        <h1 className="m-0">Clothes Ecommerce</h1>
      </Link>
      <nav>
        <Link to="/catalog" style={styles.navLink}>
          Catalog
        </Link>
        <Link to="/checkout" style={styles.navLink}>
          Checkout
        </Link>
        <Link to="/cart" className="navbar-link">
          Cart ({totalItems})
        </Link>
      </nav>
    </header>
  );
};

const styles = {
  header: {
    fontFamily: 'Arial, sans-serif',
    backgroundColor: '#f8f9fa',
    color: '#333',
  },
  logo: {
    color: '#007bff',
    fontSize: '1.5rem',
  },
  navLink: {
    margin: '0 10px',
    color: '#007bff',
    textDecoration: 'none',
  },
  cartLink: {
    margin: '0 10px',
    color: '#28a745',
    textDecoration: 'none',
  },
};

export default Header;
