<a id="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">Ecommerce Rails React App</h3>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

![Product Name Screen Shot][product-screenshot]

This is a simplified e-commerce project where I wanted to showcase some of my knowledge in Ruby on Rails and React.

I wanted to use different approaches, in the code you will find: <br />
* Design patterns as Strategy, Organizers and Interactors.
* Products import using third party API or with CSV, both as services.
* Exports for orders and products.
* Sidekiq for background processing.
* Active admin plugin for generating administration style interfaces.
* Embedded React.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

* [![RoR][RoR]][Ror-url]
* [![React][React.js]][React-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

To have the opportunity to use this project, you should follow the guide below.

### Prerequisites

You should have:
* ruby 3.3.0
  ```sh
  ruby -v
  ```
* Rails 7.1.3.4
  ```sh
  rails -v
  ```

### Installation

Before start, you need to install a few things:

1. Clone the repo
   ```sh
   git clone git@github.com:cfooostdijk/ecommerce_rr_app.git
   ```
2. Go to folder
   ```sh
   cd ecommerce_rr_app
   ```
3. Install dependencies
   ```sh
   bundle install
   ```
4. Run precompile
   ```sh
   rails assets:precompile
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

To run this proyect you'll need do:

1. Run server
   ```sh
   rails s
   ```
2. Run sidekiq
   ```sh
   bundle exec sidekiq
   ```

Also you can use:

1. Run rubocop
   ```sh
   rubocop
   ```
2. Run rspec
   ```sh
   rspec
   ```
3. Run sidecov
   ```sh
   open coverage/index.html
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
## Roadmap

### Frontend
- [ ] Improve look and feel
- [ ] Add footer
- [ ] Add filters
- [ ] Add pagination on catalog
- [ ] Add dark mode
- [ ] Add payment gateway
- [ ] Multi-language Support
    - [ ] English
    - [ ] Spanish

### Backend
- [ ] Add and improve test (rspec and capybara)
- [ ] Improve failure cases exceptions
- [ ] Improve performance using sidekiq extensively
- [ ] Add documentation using swagger or similar
- [ ] Add payment gateway
- [ ] Add logistic operator

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Cristian Oostdijk - cfo.oostdijk@gmail.com

Project Link: https://github.com/cfooostdijk/ecommerce_rr_app

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->

[product-screenshot]: app/assets/images/Homepage.png
[RoR]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Ror-url]: https://rubyonrails.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
