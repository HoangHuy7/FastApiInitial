# FastAPI Initializr

Welcome to your new FastAPI project! This project is designed to be a robust starting point for building modern, scalable, and production-ready web APIs with Python. Inspired by the convenience of Spring Initializr, it provides a clean project structure, essential features, and pre-configured tools to get you up and running in minutes.

## ✨ Features

*   **Modern Tech Stack**: Built with FastAPI, Pydantic, and SQLModel for a best-in-class developer experience.
*   **User Management**: Full authentication and authorization system out-of-the-box, including:
    *   User registration
    *   JWT-based login
    *   Password recovery
    *   Superuser creation
*   **Database Integration**: Comes with SQLModel for intuitive and powerful database interactions, configured for PostgreSQL.
*   **Asynchronous Support**: Fully async, from the database to the API endpoints.
*   **Email Notifications**: Pre-configured email sending for user actions like registration and password resets, with beautiful MJML templates.
*   **Dependency Management**: Uses `uv` for fast and reliable dependency management.
*   **Containerization**: Includes a `Dockerfile` for easy containerization and deployment.
*   **Tooling**: Pre-configured with `ruff` for linting and `mypy` for static type checking.

## 🚀 Tech Stack

*   **Backend**: FastAPI, Uvicorn
*   **Database**: PostgreSQL, SQLModel
*   **Data Validation**: Pydantic
*   **Authentication**: Passlib (for password hashing), PyJWT (for JWT tokens)
*   **Email Templating**: Jinja2, MJML
*   **Dependency Management**: `uv`
*   **Containerization**: Docker

## ⚙️ Setup and Configuration

### 1. Prerequisites

*   Python 3.10+
*   Docker (optional, for containerized deployment)
*   An instance of PostgreSQL running

### 2. Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/HoangHuy7/FastApiInitial.git
    cd FastAPIInitial
    ```

2.  **Create the environment file:**
    Copy the `.env.example` file to `.env` and update the variables with your configuration details (database credentials, secret keys, etc.).
    ```bash
    cp .env.example .env
    ```

3.  **Install dependencies:**
    Using `uv`, you can install all the required dependencies with a single command:
    ```bash
    uv pip install --system .
    ```

### 3. Running the Application

*   **Development Mode:**
    For development, you can run the application with hot-reloading enabled:
    ```bash
    uvicorn app.main:app --reload
    ```
    The API will be available at `http://127.0.0.1:8000`.

*   **Production (Docker):**
    To build and run the application using Docker:
    ```bash
    docker build -t my-fastapi-app .
    docker run -d -p 8000:8000 --env-file .env my-fastapi-app
    ```

### Build Docker Image

You can also build the Docker image separately using the following command:

```bash
docker build -t fastapi-initial .
```

This will create a Docker image named `fastapi-initial` based on the provided `Dockerfile`. You can then run this image using the `docker run` command as shown in the "Production (Docker)" section.

## API Preview

Here are a few examples of the available API endpoints. You can find more in the `test_main.http` file.

### User Registration

**Request:**
`POST /api/v1/users/`
```json
{
  "email": "user@example.com",
  "password": "a_strong_password",
  "full_name": "John Doe"
}
```

### Get Access Token

**Request:**
`POST /api/v1/login/access-token`
```json
{
  "username": "user@example.com",
  "password": "a_strong_password"
}
```

**Response:**
```json
{
  "access_token": "your-jwt-token",
  "token_type": "bearer"
}
```

### Get Current User

**Request:**
`GET /api/v1/users/me`
`Authorization: Bearer <your-jwt-token>`

**Response:**
```json
{
  "email": "user@example.com",
  "full_name": "John Doe",
  "is_active": true,
  "is_superuser": false
}
```

---

We hope you enjoy building with FastAPI Initializr. Happy coding! 🚀