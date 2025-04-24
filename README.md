# Learning Docker with Django: A Simple Hit Counter Project

Welcome! This project demonstrates how to containerize a basic web application using Docker and Docker Compose. We use **Django** (a Python web framework) and **PostgreSQL** (a relational database) as our example stack, but the **Docker concepts learned here are applicable to nearly any technology stack** (Node.js, PHP, Ruby, Go, etc.).

The goal is to provide a clear, hands-on example that teaches fundamental Docker skills by building and running this simple page-visit counter.

## What You Will Learn (Key Docker Concepts)

By running and exploring this project, you'll gain practical understanding of:

1.  🐳 **Using Official Images:** Starting services quickly using pre-built images (like `postgres` and `python`).
2.  📝 **Custom Docker Images (`Dockerfile`):** Writing your own `Dockerfile` to define the environment for your application (installing dependencies, copying code, setting commands).
3.  ⚙️ **Environment Variables:** Configuring containers dynamically (e.g., database credentials) without hardcoding them.
4.  💾 **Persistent Data (`volumes`):** Making sure your database data survives container restarts using Docker named volumes.
5.  🔗 **Container Networking:** Enabling seamless communication between containers (your Django app talking to the Postgres database) using Docker's internal networking.
6.  ⚙️ **Multi-Container Orchestration (`docker-compose.yml`):** Defining and managing your entire application stack (web + database) with a single configuration file.
7.  🔄 **Development Workflow (`bind mounts`):** Setting up live code reloading for efficient development by mounting your local code directly into the container.
8.  🚀 **Executing Commands (`docker-compose exec`):** Running commands (like database migrations) inside your running containers.
9.  ⚡ **Build Optimization (`.dockerignore`, Layer Caching):** Techniques to make your Docker image builds faster and smaller.

## Technology Stack

- **Backend:** Python 3.9+ with Django 4.x
- **Database:** PostgreSQL 15
- **Containerization:** Docker & Docker Compose

## How It Works

The application has one main page. Every time you visit or refresh this page:

1.  The Django view code runs inside the `web` container.
2.  It tells the PostgreSQL database (running in the `db` container) to record a new "hit".
3.  It then asks the database for the total number of hits recorded so far.
4.  Finally, it displays the total count on the web page.

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



IGNORE_WHEN_COPYING_START
Use code with caution. Markdown
IGNORE_WHEN_COPYING_END
Step-by-Step Instructions

    Clone the Repository:
    Get the project code onto your computer. Replace <your-repository-url> with the actual URL from GitHub.


    git clone <your-repository-url>
    cd <your-project-directory-name> # e.g., django-docker-hit-counter



    IGNORE_WHEN_COPYING_START

Use code with caution. Bash
IGNORE_WHEN_COPYING_END

Build and Start the Containers:
This is the magic of Docker Compose! This one command reads docker-compose.yml, builds the custom web image using the Dockerfile if needed, downloads the postgres image, creates a network for them, and starts both containers. The -d runs them in the background (detached).


docker-compose up -d --build



IGNORE_WHEN_COPYING_START
Use code with caution. Bash
IGNORE_WHEN_COPYING_END

(You only need --build the first time or when you change Dockerfile or requirements.txt)

Run Database Migrations:
Our Django app needs database tables to store the hit count. The web container is running, but the tables don't exist yet. We use docker-compose exec to run the Django migrate command inside the already running web container.


# Optional: Create migration files if you changed models.py
# docker-compose exec web python manage.py makemigrations counter

# Tell Django to create the database tables in the 'db' container
docker-compose exec web python manage.py migrate



IGNORE_WHEN_COPYING_START

    Use code with caution. Bash
    IGNORE_WHEN_COPYING_END

    Access the Application:
    That's it! Open your web browser and go to:
    ➡️ http://localhost:8000

    You should see the hit counter. Refresh the page – the count will go up!

Development Workflow Explained

This setup is designed for easy development:

    Live Code Reloading: Thanks to the volumes: - .:/app line in docker-compose.yml (a bind mount), the code on your computer is directly mapped into the web container. If you edit a Python file (like counter/views.py) and save it, Django's development server inside the container will automatically detect the change and reload. Just refresh your browser! No need to rebuild the image for simple code changes.

    Database Persistence: The volumes: - postgres_data:/var/lib/postgresql/data/ line for the db service creates a named volume. Docker manages this volume, and it's where PostgreSQL stores its data files. Even if you run docker-compose down (which stops and removes containers), this volume remains. When you run docker-compose up again, the db container re-attaches to the existing volume, and your hit count is still there!

Useful Docker Commands for This Project

    docker-compose up: Start services (use -d for detached mode). Add --build to force image rebuild.

    docker-compose down: Stop and remove containers, networks defined in the compose file.

    docker-compose down --volumes: Stop and remove containers, networks, AND delete named volumes (like postgres_data - use with caution, data will be lost!).

    docker-compose ps: List the running containers managed by Compose.

    docker-compose logs: View the logs from the services (add -f to follow logs in real-time).

        docker-compose logs web (Show only web logs)

        docker-compose logs db (Show only database logs)

    docker-compose exec <service_name> <command>: Execute a command inside a running container (e.g., docker-compose exec web python manage.py shell).

Understanding Key Project Files

    Dockerfile: The blueprint for building the Docker image for our Django application (web service). It specifies the base Python image, installs dependencies, copies code, and defines how to run the app.

    docker-compose.yml: The orchestration file. It defines the services (web, db), how they connect (networking), where data is stored (volumes), and configuration (environment variables).

    .dockerignore: Similar to .gitignore, this tells Docker which files/directories not to copy into the image during the build process, keeping the image clean and builds faster.

    requirements.txt: Lists the Python packages needed for the Django app. pip install -r requirements.txt is run inside the Dockerfile.

    project/settings.py: Django settings, configured to read database credentials from environment variables provided by Docker Compose.

    counter/: The Django app containing the models, views, and URLs for the hit counter logic.

Feel free to explore the code, experiment with the Docker commands, and use this as a foundation for your own containerized projects!
```
