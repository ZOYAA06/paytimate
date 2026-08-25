# Paytimate

A simple Flutter shopping cart app built to practice Flutter UI, state management, and basic app functionality.

## Features

* View a list of products with prices
* Search products by name
* Add products to the cart
* Increase or decrease product quantities
* Automatically calculate total items and price
* Clear the cart
* Disable the Clear Cart button when the cart is empty

## Tech Stack

* Flutter
* Dart

## How It Works

Products and their prices are stored locally in the app. The cart keeps track of the quantity of each selected product.

The product list updates when a search is entered, while the cart quantity and total price update automatically whenever items are added or removed.

## Getting Started

### Prerequisites

Make sure Flutter is installed and configured on your system.

### Run the project

```bash
git clone <your-repository-url>
cd paytimate
flutter pub get
flutter run
```

## Project Structure

```text
lib/
└── main.dart
```

The main application logic and UI are currently contained in `lib/main.dart`.

## Future Improvements

* Add product images
* Add product categories
* Add a dedicated cart screen
* Add persistent cart data
* Connect the app to a backend or product API

## Author

Zoya Tasnim Shaikh
