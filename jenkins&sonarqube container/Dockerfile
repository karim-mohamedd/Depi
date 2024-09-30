# Use the official Jenkins LTS image
FROM jenkins/jenkins:lts-jdk17

# Switch to the root user to install packages
USER root

RUN curl -sSL https://get.docker.com/ | sh

# Install Docker
RUN apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the Jenkins user to the Docker group
RUN usermod -aG docker jenkins

# Switch back to the Jenkins user
USER jenkins