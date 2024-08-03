import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Catalog from "../components/Catalog";
import Product from "../components/Product";
import { CartProvider } from '../components/CartContext';
import Cart from '../components/Cart';
import Checkout from '../components/Checkout';
import Confirmation from '../components/Confirmation';

export default (
  <CartProvider>
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/catalog" element={<Catalog />} />
        <Route path="/product/:id" element={<Product />} />
        <Route path="/cart" element={<Cart />} />
        <Route path="/checkout" element={<Checkout />} />
        <Route path="/confirmation" element={<Confirmation />} />
      </Routes>
    </Router>
  </CartProvider>
);
