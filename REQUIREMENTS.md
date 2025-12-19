# Take-Home Test: Full-Stack Currency Conversion App with Rate Caching

## Stack

- **Backend:** API-only (Rails preferred), Choice of your DB, Frankfurter API (https://frankfurter.dev)
- **Frontend:** React (or Angular/Vue/your choice) — simple SPA

## Problem Statement

Build a currency conversion system with two parts:

### Backend

- Convert amounts between currencies using live exchange rates from Frankfurter API.
- Cache exchange rates per currency pair in the database for 1 hour to reduce external API calls.
- Store each conversion record in the database.
- Expose a `POST /convert` endpoint to perform conversions.
- Expose a `GET /conversions` endpoint to fetch recent conversion history.
- Add validations on models (`ExchangeRate`, `Conversion`) to ensure data integrity.
- Write tests covering validations and core logic.

### Frontend (SPA)

- Provide a UI for users to input amount, source currency, and target currency.
- Call the backend API to get conversion results.
- Display the converted amount, exchange rate used, and timestamp when the rate was fetched.
- Show a list of recent conversions fetched from the backend.
