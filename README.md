# Shoes App

Shoes App is a fully featured mobile eCommerce application built using Flutter, designed to offer a seamless shopping experience for users interested in stylish footwear. The app supports dynamic product browsing, secure checkout, and personalized user management all powered by a scalable backend stack.

I led the development of both the frontend and backend, focusing on clean architecture, performance, and real-time interactivity.

---

## Key Features & Functionality

- **Product Discovery:** Browse shoes by brand and category with intuitive filtering and responsive UI.
- **Product Details:** View rich information including images, descriptions, sizes, and pricing.
- **Cart & Wishlist:** Add shoes to a shopping cart or mark them as favorites for later viewing.
- **Address Management:** Add, update, and delete multiple delivery destinations.
- **Secure Payments:** Integrated with Stripe for smooth and secure checkout.
- **Order Management:** Users can track current orders and review order history.
- **User Authentication:** Implemented with Supabase Auth, supporting sign up, sign in, sign out.
- **Account Recovery:** Forgot password and change password flows included.
- **Profile Settings:** Edit username and upload a profile picture using Supabase Storage.
- **Performance Optimized:** Redis used for caching and speeding up user experience.
- **Clean Architecture:** The project follows a scalable and testable clean architecture pattern.

---
## What I Learned
- Building and consuming REST APIs using Dart Frog
- Managing real-time data with Supabase and caching strategies with Redis
- Handling payment flows and integrating Stripe SDK in Flutter
- Structuring a scalable codebase using Clean Architecture
  
---
## Demo

https://github.com/user-attachments/assets/22941de3-9ebb-429d-8b85-e0890ee3b708


--

## Tech Stack
- **Frontend:** Flutter, Dart
- **Backend:** Dart frog
- **Auth & DB:** Supabase
- **Payments:** Stripe
- **State Management:** Bloc
- **Data Caching:** Redis
- **Containerization:** Docker
- **Architecture:** Clean Architecture

---
## Getting Started

### Prerequisites

- Flutter SDK (>=3.29.1)
- Dart (>=3.7.0)
- Supabase project setup
- Stripe account & API keys
- Redis server running
- Docker for image creation

### Installation

```bash
git clone https://github.com/ONjie/shoes_app.git
cd shoes_app
flutter pub get
flutter run
```

## Folder Structure

The project follows the Clean Architecture pattern:
 <pre>shoes_app/
 ┣ assets/
 ┃ ┣ fonts/
 ┃ ┣ icons/
 ┃ ┗ lottie/
 ┣ lib/
 ┃ ┣ core/
 ┃ ┃  ┣ exceptions/
 ┃ ┃  ┣ failures/
 ┃ ┃  ┣ helpers/
 ┃ ┃  ┣ local_database/
 ┃ ┃  ┣ network/
 ┃ ┃  ┣ permissions/
 ┃ ┃  ┣ route/
 ┃ ┃  ┣ utils/
 ┃ ┃  ┗ core.dart
 ┃ ┣ features/
 ┃ ┃  ┣ authentication/
 ┃ ┃  ┃  ┣ data/
 ┃ ┃  ┃  ┣ domain/
 ┃ ┃  ┃  ┗ presentation/
 ┃ ┃  ┣ cart/
 ┃ ┃  ┃  ┣ data/
 ┃ ┃  ┃  ┣ domain/
 ┃ ┃  ┃  ┗ presentation/
 ┃ ┃  ┣ checkout/
 ┃ ┃  ┃  ┣ data/
 ┃ ┃  ┃  ┣ domain/
 ┃ ┃  ┃  ┗ presentation/
 ┃ ┃  ┣ delivery_destination/
 ┃ ┃  ┃  ┣ data/
 ┃ ┃  ┃  ┣ domain/
 ┃ ┃  ┃  ┗ presentation/
 ┃ ┃  ┣ orders/
 ┃ ┃  ┃  ┣ data/
 ┃ ┃  ┃  ┣ domain/
 ┃ ┃  ┃  ┗ presentation/
 ┃ ┃  ┣ shoes/
 ┃ ┃  ┃  ┣ data/
 ┃ ┃  ┃  ┣ domain/
 ┃ ┃  ┃  ┗ presentation/
 ┃ ┃  ┗ users/
 ┃ ┃  ┃  ┣ data/
 ┃ ┃  ┃  ┣ domain/
 ┃ ┃  ┃  ┗ presentation/
 ┃ ┣ injection_container.dart
 ┃ ┣ main.dart
 ┃ ┗ onboarding_screen.dart
 ┣ shoes_api/
 ┃ ┣ lib/
 ┃ ┃ ┣ core/
 ┃ ┃ ┃ ┣ exceptions/
 ┃ ┃ ┃ ┣ failures/
 ┃ ┃ ┃ ┗ utils/
 ┃ ┃ ┣ env/
 ┃ ┃ ┗ src/
 ┃ ┃ ┃ ┣ shoes/
 ┃ ┃ ┃ ┃ ┣ data_sources/
 ┃ ┃ ┃ ┃ ┣ models/
 ┃ ┃ ┃ ┃ ┗ repositories/
 ┃ ┣ routes/
 ┃ ┣ test/
 ┃ ┣ pubspec.ymal
 ┃ ┗ README.md
 ┣ pubspec.yaml
 ┗ README.md
 </pre>


---
### Made with 💚 by Muhammed O Njie
