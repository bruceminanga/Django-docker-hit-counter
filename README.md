# 🐳 Django Docker Hit Counter

A hands-on project demonstrating how to containerize a Django web application using Docker and Docker Compose, progressing from basic setups to production-ready configurations with Nginx and Gunicorn.

## 📋 Overview

This project showcases a simple but practical page visit counter application built with Django and PostgreSQL, deployed using Docker. It serves as a learning resource for Docker concepts that apply to virtually any tech stack.

## 🏗️ Project Architecture

### System Components

This project uses a three-tier architecture with the following containerized services:

1. **Web Server (Nginx)**

   - Handles incoming HTTP requests
   - Serves static files directly
   - Forwards dynamic requests to the application server

2. **Application Server (Gunicorn + Django)**

   - Processes business logic
   - Renders dynamic content
   - Manages database operations

3. **Database (PostgreSQL)**
   - Stores visit counter data
   - Maintains data persistence

### Data Flow

When a user visits the site:

1. The request arrives at the **Nginx** container (port 80)
2. Nginx determines the request type:
   - For static files (`/static/*`): Serves directly from the shared volume
   - For dynamic requests: Forwards to Gunicorn
3. **Gunicorn** receives the request and passes it to Django
4. **Django** processes the request:
   - Records a new page visit in PostgreSQL
   - Retrieves the updated count
   - Generates HTML response
5. The response returns through the same path: Django → Gunicorn → Nginx → User

### Data Persistence

The project uses Docker volumes for persistence:

- **postgres_data**: Stores PostgreSQL database files
- **staticfiles**: Contains static assets collected from Django
- **Code volume**: Bind mount for development that synchronizes local changes

### Configuration Management

Environment variables stored in a `.env` file (not tracked in Git) provide configuration for:

- Database credentials
- Django secret key
- Debug settings

Docker Compose injects these variables into the appropriate containers at runtime.

## 🎓 What I Learned

Through this project, I gained practical experience with:

- Using official Docker images (`postgres`, `python`, `nginx`)
- Writing custom Dockerfiles for my applications
- Setting up Gunicorn as a production WSGI server
- Configuring Nginx as a reverse proxy
- Managing static files efficiently
- Implementing secrets management with `.env` files
- Ensuring data persistence with Docker volumes
- Setting up container networking
- Orchestrating multiple containers with Docker Compose
- Creating an efficient development workflow
- Executing commands in running containers
- Optimizing Docker builds
- Implementing basic CI/CD with GitHub Actions

## 🛠️ Technology Stack

- **Backend:** Python 3.9+ with Django 4.x
- **WSGI Server:** Gunicorn
- **Reverse Proxy:** Nginx
- **Database:** PostgreSQL 15
- **Containerization:** Docker & Docker Compose
- **CI/CD:** GitHub Actions

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose
  ```bash
  # Verify installation
  docker --version
  docker-compose --version
  ```

### Setup Instructions

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd django-docker-hit-counter
   ```

2. **Create the `.env` file**

   ```
   # Database Credentials
   POSTGRES_DB=mydatabase
   POSTGRES_USER=myuser
   POSTGRES_PASSWORD=mysecretpassword

   # Django Secret Key (Generate a new one!)
   # python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'
   DJANGO_SECRET_KEY='your_strong_random_secret_key_here'

   # Other Settings
   DEBUG=1  # Set to 0 for production simulation
   ```

   ⚠️ **Important:** Add `.env` to your `.gitignore`!

3. **Build and start containers**

   ```bash
   docker-compose up -d --build
   ```

4. **Run database migrations**

   ```bash
   docker-compose exec web python manage.py migrate
   ```

5. **Collect static files**

   ```bash
   docker-compose exec web python manage.py collectstatic --noinput
   ```

6. **Access the application**
   - Open [http://localhost/](http://localhost/)
   - Watch the counter increment with each refresh!

## 💻 Development Workflow

- **Live Code Reloading:** Local changes are synced to the container via bind mounts
- **Database Persistence:** Named volumes ensure data survives container restarts
- **Static Files:** Nginx serves static files directly from a shared volume

## 📚 Common Docker Commands

| Command                         | Description                                        |
| ------------------------------- | -------------------------------------------------- |
| `docker-compose up -d`          | Start services in detached mode                    |
| `docker-compose up -d --build`  | Start services, forcing image rebuild              |
| `docker-compose down`           | Stop and remove containers, networks               |
| `docker-compose down --volumes` | Stop containers and delete volumes (⚠️ data loss!) |
| `docker-compose ps`             | List running containers                            |
| `docker-compose logs`           | View logs from all services                        |
| `docker-compose logs web`       | View logs from the web service only                |
| `docker-compose restart web`    | Restart the web service after code changes         |

## 📁 Key Project Files

| File                       | Purpose                                             |
| -------------------------- | --------------------------------------------------- |
| `Dockerfile`               | Blueprint for the Django/Gunicorn application image |
| `docker-compose.yml`       | Orchestrates services, volumes, and networking      |
| `.env`                     | Stores secrets and configuration variables          |
| `nginx/nginx.conf`         | Nginx configuration for static files and proxying   |
| `requirements.txt`         | Python dependencies                                 |
| `project/settings.py`      | Django configuration                                |
| `.github/workflows/ci.yml` | GitHub Actions workflow for CI                      |

## 🔄 Continuous Integration

This project includes a basic CI pipeline using GitHub Actions that performs:

- Code checkout
- Python setup
- Dependency installation
- Code linting
- Django's built-in checks

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
