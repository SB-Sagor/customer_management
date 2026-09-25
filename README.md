# Customer Management App

A Flutter application developed to manage and browse customer accounts using Hisabplus REST APIs. Built with GetX for state management and page routing.

## Overview

This project was built as a practical assessment task. It covers token-based authentication, real-time customer search, paginated infinite scrolling, and dedicated customer profile screens.

## Features

- Authentication: Login flow integrating with Hisabplus API and handling user access tokens.
- Paginated Customer List: Loads 20 records per request with an infinite scroll listener attached to ListView.builder.
- Search Functionality: Filters customer records on input change with query reset, keyboard unfocus, and back navigation handling via PopScope.
- Avatar Fallback: Loads network images when available; displays the customer's first name letter if image data is missing or empty.
- Customer Details: Shows detailed contact information, address, customer type, active/inactive status, and due amounts formatted in BDT.
- Navigation Drawer: Basic profile overview with logout confirmation and session reset.
- Error Handling: Handles null/empty API values safely and wraps views inside scrollable layouts to prevent pixel overflows.

## Tech Stack

- Framework: Flutter
- State Management: GetX
- HTTP Client: http
- Icons: Iconsax

## Project Structure

lib/
├── core/
│   ├── common/widgets/
│   └── constants/
├── modules/
│   ├── auth/
│   │   ├── controllers/
│   │   └── views/
│   └── customer/
│       ├── controllers/
│       ├── views/
│       └── widgets/
└── main.dart

## How to Run

1. Clone the repository:
   git clone https://github.com/your-username/customer-management-flutter.git
   cd customer-management-flutter

2. Fetch dependencies:
   flutter pub get

3. Run the project:
   flutter run

## API Endpoints

- POST https://www.hisabplus.com/Values/LogIn
- GET https://www.hisabplus.com/Values/GetCustomerList?searchquery={query}&pageNo={page}&pageSize=20&SortyBy=Balance
