import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4 text-center">Clothes Ecommerce</h1>
        <p className="lead text-center">
          A curated list of clothes for the best outfit.
        </p>
        <hr className="my-4" />
        <div className="container secondary-color d-flex justify-content-between">
          <Link
            to="/clothes"
            className="btn btn-lg custom-button mx-2"
            role="button"
          >
            View Clothes
          </Link>
          <a
            href="/admin"
            className="btn btn-lg custom-button mx-2"
            role="button"
          >
            Go Dashboard
          </a>
        </div>
      </div>
    </div>
  </div>
);
