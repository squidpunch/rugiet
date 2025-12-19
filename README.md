# Currency Conversion App

A full-stack currency conversion application built with Rails API backend and Next.js frontend in a monorepo structure.

## Project Structure

```
rugiet/
├── backend/              # Rails API (PostgreSQL)
│   ├── app/
│   ├── config/
│   ├── Dockerfile.dev
│   └── .env.example
├── frontend/             # Next.js SPA (TypeScript + Tailwind)
│   ├── app/
│   ├── Dockerfile.dev
│   └── .env.example
├── docker-compose.yml    # Local development orchestration
├── .gitignore
└── README.md             # This file
```

## Tech Stack

### Backend
- Ruby on Rails 8.0 (API mode)
- Ruby 3.4.8
- PostgreSQL 15
- Rack CORS

### Frontend
- Next.js 15+
- TypeScript
- Tailwind CSS
- ESLint

## Prerequisites

- **Docker and Docker Compose** (recommended)
- **OR** for local development:
  - Ruby 3.4.8
  - Node.js 20+
  - PostgreSQL 15+

## Setup Instructions

### 1. Clone and Navigate

```bash
cd rugiet
```

### 2. Environment Configuration

#### Backend

```bash
cd backend
cp .env.example .env
```

Edit `.env` and set your values (or use defaults for local development).

#### Frontend

```bash
cd frontend
cp .env.example .env.local
```

Edit `.env.local` if needed (defaults should work for local development).

### 3. Start Development Environment

#### Using Docker (Recommended)

```bash
# From the root directory
docker-compose up --build

# Backend API: http://localhost:3000
# Frontend: http://localhost:3001
# PostgreSQL: localhost:5432
```

First time setup with Docker:
```bash
# In a new terminal, create and migrate the database
docker-compose exec backend rails db:create db:migrate
```

## Development Workflow

### Adding Database Migrations

```bash
cd backend
rails generate migration MigrationName
rails db:migrate
```

### Running Rails Console

```bash
docker-compose exec backend rails console
```

### Viewing Logs

```bash
# Docker - all services
docker-compose logs -f

# Docker - specific service
docker-compose logs -f backend
docker-compose logs -f frontend
```

### Stopping Services

```bash
# Docker
docker-compose down

# Docker with volume cleanup
docker-compose down -v
```

### Running Tests

```bash
# run the full back end suite
docker-compose exec -T backend rspec
```