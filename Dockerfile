# Dockerfile

# 1. Base Image: Use an official Python runtime
FROM python:3.9-slim-buster

# 2. Set Environment Variables
ENV PYTHONDONTWRITEBYTECODE 1 # Prevents python from writing pyc files
ENV PYTHONUNBUFFERED 1       # Prevents python from buffering stdout/stderr

# 3. Set Work Directory: Create and switch to the /app directory in the container
WORKDIR /app

# 4. Install System Dependencies (if needed): psycopg2 might need postgresql client libs
# RUN apt-get update && apt-get install -y --no-install-recommends gcc libpq-dev && rm -rf /var/lib/apt/lists/*
# Note: psycopg2-binary often includes these, try without first. If build fails, uncomment the RUN line above.

# 5. Install Python Dependencies: Copy only requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy Application Code: Copy the rest of your application code
COPY . .

# 7. Expose Port: Inform Docker the container listens on port 8000
EXPOSE 8000

# 8. Default Command: Use Gunicorn to run the application
# --bind 0.0.0.0:8000 : Listen on port 8000 on all available network interfaces inside the container
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "project.wsgi:application"]