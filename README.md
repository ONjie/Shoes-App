# Shoes App

A fully featured fullstack mobile ecommerce app built with Flutter where users can browse shoes by brand and category, manage their profile, add and manage their delivery destinations, and purchase securely via Stripe. Backed by a modern backend stack using Supabase, Redis, and Dart Frog.

---

## Features

- Browse a wide range of shoes by category and brand
- Select and view detailed info about shoes
- Add shoes to cart and favorite list
- Add, update and delete delivery destination
- Checkout securely using Stripe
- View orders and order history
- Sign up, Sign in, Sign out
- Reset password, Change password
- Update profile picture and username

---
### What I Learned
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
