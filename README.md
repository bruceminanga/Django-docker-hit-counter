# Django-docker-hit-counter

# Django Docker Hit Counter

A simple web application built with Django and PostgreSQL, containerized using Docker and Docker Compose. The application displays a counter that increments each time the main page is visited.

This project serves primarily as a hands-on learning exercise to understand fundamental Docker concepts in the context of a web application stack.

## Tech Stack

- Python 3.9+
- Django 4.x
- PostgreSQL 15
- Docker
- Docker Compose

## Features

- Displays a web page showing the total number of visits.
- Persists the visit count in a PostgreSQL database.
- Entire application stack (web app + database) managed by Docker Compose.
- Development environment with live code reloading enabled.

## Getting Started

Follow these instructions to get the project up and running on your local machine using Docker.

### Prerequisites

- **Docker:** Ensure you have Docker installed. Download from [Docker's official website](https://docs.docker.com/get-docker/).
- **Docker Compose:** Docker Desktop typically includes Docker Compose. If using Docker Engine on Linux, you might need to install it separately (follow Docker docs).

Verify installations:

```bash
docker --version
docker-compose --version # or 'docker compose version' for newer integrations



IGNORE_WHEN_COPYING_START
Use code with caution. Markdown
IGNORE_WHEN_COPYING_END
Installation & Running

    Clone the repository:
    (Remember to replace your-repository-url with the actual URL of your GitHub repository)


    git clone <your-repository-url>
    cd <your-project-directory-name> # e.g., django-docker-hit-counter



    IGNORE_WHEN_COPYING_START

Use code with caution. Bash
IGNORE_WHEN_COPYING_END

Build and Start the Containers:
This command builds the custom Docker image for the Django application (if it doesn't exist or the Dockerfile changed) and starts both the web (Django) and db (PostgreSQL) services defined in docker-compose.yml. The -d flag runs them in detached mode (in the background).


docker-compose up -d --build



IGNORE_WHEN_COPYING_START
Use code with caution. Bash
IGNORE_WHEN_COPYING_END

Apply Database Migrations:
The web container needs to create the necessary database tables defined in the Django models. Execute the migrate command inside the running web container using docker-compose exec:


# (Optional but good practice) Create migration files if models changed
docker-compose exec web python manage.py makemigrations counter

# Apply migrations to the database
docker-compose exec web python manage.py migrate



IGNORE_WHEN_COPYING_START

    Use code with caution. Bash
    IGNORE_WHEN_COPYING_END

    Access the Application:
    Open your web browser and navigate to:
    http://localhost:8000

    You should see the hit counter page! Refresh the page to see the count increase.

Usage

    Viewing the App: Access http://localhost:8000.

    Live Reloading: Edit Python files (e.g., counter/views.py) in your local editor. Save the changes and refresh the browser page – the changes should be reflected immediately without restarting the containers (thanks to the bind mount volume).

    Stopping the Application:


    docker-compose down



    IGNORE_WHEN_COPYING_START

Use code with caution. Bash
IGNORE_WHEN_COPYING_END

This command stops and removes the containers and the network created by Compose.

Stopping and Removing Data: To stop the containers AND remove the persistent PostgreSQL data volume (resetting the counter):


docker-compose down --volumes



IGNORE_WHEN_COPYING_START
Use code with caution. Bash
IGNORE_WHEN_COPYING_END

Viewing Logs: To see the output from the containers (useful for debugging):


# View logs for the web service
docker-compose logs -f web

# View logs for the database service
docker-compose logs -f db

# View logs for all services
docker-compose logs -f



IGNORE_WHEN_COPYING_START

    Use code with caution. Bash
    IGNORE_WHEN_COPYING_END

    (Press Ctrl+C to stop following logs).

Docker Concepts Learned

This project provides practical experience with the following core Docker concepts:

    Using Official Images: Leveraging pre-built images from Docker Hub (postgres:15-alpine, python:3.9-slim-buster) as base layers or standalone services.

    Container Configuration with Environment Variables: Passing configuration (like database credentials) into containers at runtime using the environment section in docker-compose.yml and reading them within the application (os.environ.get in settings.py).

    Creating Custom Docker Images (Dockerfile): Writing instructions (FROM, WORKDIR, ENV, RUN, COPY, EXPOSE, CMD) to build a tailored image containing the Django application, its dependencies, and runtime configuration.

    Optimizing Builds (.dockerignore, Layer Caching): Using .dockerignore to exclude unnecessary files from the build context, speeding up builds and reducing image size. Structuring the Dockerfile (e.g., copying requirements.txt and running pip install before copying application code) to take advantage of Docker's layer caching.

    Persistent Data (volumes): Using Docker named volumes (postgres_data in docker-compose.yml) to persist database data even if the db container is stopped and removed, ensuring data durability.

    Container Networking: Understanding how Docker Compose automatically creates a network, allowing containers (services like web and db) to communicate with each other using their service names as hostnames (e.g., HOST: 'db' in Django settings).

    Multi-Container Orchestration (docker-compose.yml): Defining and managing a multi-service application (web application + database) in a single configuration file. Using depends_on to manage startup order dependencies.

    Development Workflow (Bind Mounts): Using bind mounts (volumes: - .:/app in docker-compose.yml) to map local source code directly into the running container, enabling live code reloading during development without needing to rebuild the image for every code change.

    Executing Commands in Running Containers (docker-compose exec): Running administrative or maintenance tasks (like python manage.py migrate) inside a specific, already-running service container.

File Structure Highlight


.
├── .dockerignore         # Specifies intentionally untracked files for Docker build
├── Dockerfile            # Instructions to build the Django 'web' service image
├── docker-compose.yml    # Defines the services (web, db), volumes, network
├── manage.py             # Django's command-line utility
├── project/              # Django project configuration directory
│   ├── __init__.py
│   ├── settings.py       # Django settings (configured for Docker env vars)
│   ├── urls.py           # Main project URL routing
│   └── wsgi.py
├── counter/              # Django app for the hit counter logic
│   ├── __init__.py
│   ├── admin.py
│   ├── apps.py
│   ├── migrations/
│   ├── models.py         # Database model (Hit)
│   ├── tests.py
│   ├── urls.py           # App-specific URL routing
│   └── views.py          # View logic for displaying the counter
├── requirements.txt      # Python package dependencies
└── README.md             # This file


```
