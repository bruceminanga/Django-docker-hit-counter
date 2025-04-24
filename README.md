# Learning Docker with Django: A Simple Hit Counter Project

Welcome! This project demonstrates how to containerize a basic web application using Docker and Docker Compose. We use **Django** (a Python web framework) and **PostgreSQL** (a relational database) as our example stack, but the **Docker concepts learned here are applicable to nearly any technology stack** (Node.js, PHP, Ruby, Go, etc.).

The goal is to provide a clear, hands-on example that teaches fundamental Docker skills by building and running this simple page-visit counter.

## What You Will Learn (Key Docker Concepts)

By running and exploring this project, you'll gain practical understanding of:

1. 🐳 **Using Official Images:** Starting services quickly using pre-built images (like `postgres` and `python`).
2. 📝 **Custom Docker Images (`Dockerfile`):** Writing your own `Dockerfile` to define the environment for your application (installing dependencies, copying code, setting commands).
3. ⚙️ **Environment Variables:** Configuring containers dynamically (e.g., database credentials) without hardcoding them.
4. 💾 **Persistent Data (`volumes`):** Making sure your database data survives container restarts using Docker named volumes.
5. 🔗 **Container Networking:** Enabling seamless communication between containers (your Django app talking to the Postgres database) using Docker's internal networking.
6. ⚙️ **Multi-Container Orchestration (`docker-compose.yml`):** Defining and managing your entire application stack (web + database) with a single configuration file.
7. 🔄 **Development Workflow (`bind mounts`):** Setting up live code reloading for efficient development by mounting your local code directly into the container.
8. 🚀 **Executing Commands (`docker-compose exec`):** Running commands (like database migrations) inside your running containers.
9. ⚡ **Build Optimization (`.dockerignore`, Layer Caching):** Techniques to make your Docker image builds faster and smaller.

## Technology Stack

- **Backend:** Python 3.9+ with Django 4.x
- **Database:** PostgreSQL 15
- **Containerization:** Docker & Docker Compose

## How It Works

The application has one main page. Every time you visit or refresh this page:

1. The Django view code runs inside the `web` container.
2. It tells the PostgreSQL database (running in the `db` container) to record a new "hit".
3. It then asks the database for the total number of hits recorded so far.
4. Finally, it displays the total count on the web page.

## Getting Started: Running the Project

Let's get this running on your machine!

### Prerequisites

Make sure you have Docker and Docker Compose installed and running.

- **Docker:** Download from [Docker's official website](https://docs.docker.com/get-docker/).
- **Docker Compose:** Usually included with Docker Desktop (Mac/Windows). Linux users might need a separate install (see Docker docs).

Verify your installation in your terminal:

```bash
docker --version
docker-compose --version # or 'docker compose version'
```

### Step-by-Step Instructions

1. **Clone the Repository:**

   ```bash
   git clone <your-repository-url>
   cd <your-project-directory-name> # e.g., django-docker-hit-counter
   ```

2. **Build and Start the Containers:**

   ```bash
   docker-compose up -d --build
   ```

   _(You only need --build the first time or when you change Dockerfile or requirements.txt)_

3. **Run Database Migrations:**

   ```bash
   # Optional: Create migration files if you changed models.py
   # docker-compose exec web python manage.py makemigrations counter

   # Tell Django to create the database tables in the 'db' container
   docker-compose exec web python manage.py migrate
   ```

4. **Access the Application:**
   Open your web browser and go to:
   http://localhost:8000

   You should see the hit counter. Refresh the page – the count will go up!

## Development Workflow Explained

This setup is designed for easy development:

- **Live Code Reloading:** Thanks to the `volumes: - .:/app` line in docker-compose.yml (a bind mount), the code on your computer is directly mapped into the web container. If you edit a Python file (like counter/views.py) and save it, Django's development server inside the container will automatically detect the change and reload. Just refresh your browser! No need to rebuild the image for simple code changes.

- **Database Persistence:** The `volumes: - postgres_data:/var/lib/postgresql/data/` line for the db service creates a named volume. Docker manages this volume, and it's where PostgreSQL stores its data files. Even if you run `docker-compose down` (which stops and removes containers), this volume remains. When you run `docker-compose up` again, the db container re-attaches to the existing volume, and your hit count is still there!

## Useful Docker Commands for This Project

| Command                                          | Description                                              |
| ------------------------------------------------ | -------------------------------------------------------- |
| `docker-compose up -d`                           | Start services in detached mode                          |
| `docker-compose up -d --build`                   | Start services, forcing image rebuild                    |
| `docker-compose down`                            | Stop and remove containers, networks                     |
| `docker-compose down --volumes`                  | Stop containers and delete volumes (caution: data loss!) |
| `docker-compose ps`                              | List running containers managed by Compose               |
| `docker-compose logs`                            | View logs from all services                              |
| `docker-compose logs web`                        | View logs from the web service only                      |
| `docker-compose logs -f`                         | Follow logs in real-time                                 |
| `docker-compose exec web python manage.py shell` | Execute Django shell in the web container                |

## Understanding Key Project Files

| File                    | Purpose                                                        |
| ----------------------- | -------------------------------------------------------------- |
| **Dockerfile**          | Blueprint for building the Django application image            |
| **docker-compose.yml**  | Orchestration file defining services, networks, volumes        |
| **.dockerignore**       | Specifies which files to exclude from the Docker context       |
| **requirements.txt**    | Lists Python dependencies for the Django app                   |
| **project/settings.py** | Django configuration with database settings from env variables |
| **counter/**            | Django app with models, views, and URLs for the counter logic  |

Feel free to explore the code, experiment with the Docker commands, and use this as a foundation for your own containerized projects!
