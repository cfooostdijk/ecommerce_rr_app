import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Catalog = () => {
  const navigate = useNavigate();
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const url = "/api/v1/products";
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((res) => setProducts(res));
  }, []);

  const allProducts = products.map((product, index) => (
    <div key={index} className="col-md-6 col-lg-4">
      <div className="card mb-4">
        <img
          src={product.image}
          className="card-img-top"
          alt={`${product.name} image`}
        />
        <div className="card-body">
          <h5 className="card-title">{product.name}</h5>
          <Link to={`/product/${product.id}`} className="btn custom-button">
            View Product
          </Link>
        </div>
      </div>
    </div>
  ));
  const noProduct = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>
        No products yet...
      </h4>
    </div>
  );

  return (
    <>
      <section className="jumbotron jumbotron-fluid text-center">
        <div className="container py-5">
          <h1 className="display-4">Product for every occasion</h1>
          <p className="lead text-muted">
            We’ve pulled together our most popular products, our latest
            additions, and our editor’s picks, so there’s sure to be something
            tempting for you to try.
          </p>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="row">
            {products.length > 0 ? allProducts : noProduct}
          </div>
          <Link to="/" className="btn btn-link">
            Home
          </Link>
        </main>
      </div>
    </>
  );
};

export default Catalog;
