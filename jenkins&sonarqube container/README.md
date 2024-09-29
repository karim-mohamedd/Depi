
---

# Jenkins and SonarQube Docker Setup

This project provides a simple way to run Jenkins and SonarQube using Docker Compose. It allows you to leverage Docker-in-Docker capabilities by mounting the Docker socket, enabling Jenkins to run Docker containers as part of your CI/CD pipeline.



## Prerequisites

- Docker: Ensure you have Docker installed on your machine. [Installation Instructions](https://docs.docker.com/get-docker/)
- Docker Compose: Make sure Docker Compose is installed. [Installation Instructions](https://docs.docker.com/compose/install/)




## Configuration

- **Jenkins**:
  - Accessible at `http://localhost:8080`
  - The Jenkins container can execute Docker commands due to the mounted Docker socket.

- **SonarQube**:
  - Accessible at `http://localhost:9000`
  - Uses PostgreSQL as its database.

## Usage

1. **Start the services** using Docker Compose:
   ```bash
   docker-compose up -d
   ```

2. **Verify that the containers are running**:
   ```bash
   docker-compose ps
   ```

3. **Stop the services** when you're done:
   ```bash
   docker-compose down
   ```

## Accessing Services

- **Jenkins**: Open your web browser and navigate to [http://localhost:8080](http://localhost:8080).
- **SonarQube**: Open your web browser and navigate to [http://localhost:9000](http://localhost:9000).

