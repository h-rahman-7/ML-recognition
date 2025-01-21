# Stage 1: Build Stage
FROM python:3.12-slim AS base

WORKDIR /app

# Install necessary system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir flask ultralytics

# Copy application code
COPY . .

# Stage 2: Runtime Image
FROM python:3.12-slim

WORKDIR /app

# Install necessary system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy installed Python dependencies and application code from the build stage
COPY --from=base /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=base /app /app

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["python", "app.py"]