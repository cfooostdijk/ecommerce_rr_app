import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Product = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [product, setProduct] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const url = `/api/v1/products/${params.id}`;
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((data) => {
        setProduct(data);
        setLoading(false);
      })
      .catch(() => {
        setError("Product not found or an error occurred.");
        setLoading(false);
        navigate("/products");
      });
  }, [params.id, navigate]);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;

  return (
    <div style={styles.productPage}>
      <div style={styles.hero} className="position-relative d-flex align-items-center justify-content-center">
        <img
          src={product.image_url}
          alt={`${product.title} image`}
          style={styles.heroImg}
        />
        <div style={styles.overlay} className="position-absolute" />
        <h1 style={styles.productTitle} className="display-4 position-relative text-white">
          {product.title}
        </h1>
      </div>
      <div style={styles.container} className="container py-5">
        <div className="row">
          <div className="col-sm-12 col-lg-3">
            <ul className="list-group">
              <h5 className="mb-2">Details</h5>
              <li className="list-group-item" style={styles.listGroupItem}>
                <strong>Price: </strong>${product.price}
              </li>
              <li className="list-group-item" style={styles.listGroupItem}>
                <strong>Description: </strong>{product.description}
              </li>
            </ul>
          </div>
        </div>
        <Link to="/catalog" style={styles.btnLink} className="btn btn-link mt-4">
          Back to products
        </Link>
      </div>
    </div>
  );
};

const styles = {
  productPage: {
    fontFamily: 'Arial, sans-serif'
  },
  hero: {
    height: '400px',
    position: 'relative'
  },
  heroImg: {
    objectFit: 'cover',
    width: '100%',
    height: '100%',
    filter: 'brightness(60%)'
  },
  productTitle: {
    zIndex: 1,
    position: 'relative',
    color: 'white',
    textAlign: 'center'
  },
  overlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    background: 'rgba(0, 0, 0, 0.5)'
  },
  container: {
    maxWidth: '1200px',
    margin: 'auto',
    padding: '20px'
  },
  listGroupItem: {
    border: 'none',
    padding: '10px 0'
  },
  btnLink: {
    color: '#007bff',
    textDecoration: 'none'
  }
};

export default Product;
