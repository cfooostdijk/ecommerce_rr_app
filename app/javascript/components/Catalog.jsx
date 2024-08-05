import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import Header from "./Header";

const Catalog = () => {
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

  const allProducts = products.map((product) => (
    <div key={product.id} className="col-md-6 col-lg-4 mb-4">
      <div className="card border-light shadow rounded">
        <img
          src={product.image_url}
          className="card-img-top rounded-top"
          alt={`${product.title} image`}
          style={{ objectFit: "cover", height: "200px" }}
        />
        <div className="card-body">
          <h5 className="card-title">{product.title}</h5>
          <p className="card-text text-muted">Price: ${product.price}</p>
          <Link to={`/product/${product.id}`} className="btn custom-button">
            View Product
          </Link>
        </div>
      </div>
    </div>
  ));

  const noProduct = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>No products yet...</h4>
    </div>
  );

  return (
    <>
      <Header />
      <section className="jumbotron jumbotron-fluid text-center mb-4">
        <div className="container py-5">
          <h1 className="display-4">Products for Every Occasion</h1>
          <p className="lead text-muted">
            We’ve pulled together our most popular products, our latest additions,
            and our editor’s picks, so there’s sure to be something tempting for you to try.
          </p>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="row">
            {products.length > 0 ? allProducts : noProduct}
          </div>
          <Link to="/" className="btn btn-link mt-4">
            Home
          </Link>
        </main>
      </div>
    </>
  );
};

export default Catalog;
