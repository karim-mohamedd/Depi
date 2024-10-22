
---

# Depi-Pipeline - CI/CD Pipeline

This README file contains a Description for Jenkins pipeline that automates the process of building, analyzing, and deploying microservices. The pipeline is designed to handle multiple services in parallel, ensuring a smooth and efficient CI/CD workflow for the **Depi** project.

## Table of Contents
- [Pipeline Overview](#pipeline-overview)
- [Pipeline Stages](#pipeline-stages)
  - [Git Checkout](#git-checkout)
  - [Code Analysis (SonarQube)](#code-analysis-sonarqube)
  - [Build Services](#build-services)
  - [Post-Build Notifications](#post-build-notifications)
- [Pre-requisites](#pre-requisites)
- [Configuration](#configuration)
- [Team](#team)
- [Contribution](#contribution)

## Pipeline Overview

This pipeline integrates with Jenkins and uses the following key technologies:
- **Git** for version control.
- **SonarQube** for static code analysis and quality gate checks.
- **Docker** for building and managing microservices.
- **Slack** for post-build notifications.

The pipeline is configured to build a set of microservices in parallel, ensuring faster execution times. Each microservice is built as a Docker container, pushed to a Docker registry, and cleaned up afterward to optimize disk space.

## Pipeline Stages

### 1. Git Checkout
In the first stage, the pipeline checks out the latest version of the code from the Git repository. This ensures that the pipeline always works on the most up-to-date code.

- **Branch**: The pipeline fetches code from the `karim` branch.
- **Repository URL**: `https://github.com/karim-mohamedd/Depi.git`

```groovy
git branch: 'karim', url: 'https://github.com/karim-mohamedd/Depi.git'
```

### 2. Code Analysis (SonarQube)
The pipeline integrates with **SonarQube** to perform static analysis on the codebase. This step ensures that the code adheres to the project's coding standards and passes quality gate checks.

- **Scanner**: The `sonar-scanner` tool is used to perform the analysis.
- **Project Key**: `Depi-Pipeline`
- **Project Name**: `Depi-Pipeline`

```groovy
withSonarQubeEnv('sonar') {
    sh '''
        $SCANNER/bin/sonar-scanner \
        -Dsonar.projectKey=Depi-Pipeline \
        -Dsonar.projectName=Depi-Pipeline \
        -Dsonar.java.binaries=.
    '''
}
```

### 3. Build Services
In this stage, multiple microservices are built in parallel. Each microservice is built as a Docker image and pushed to the Docker registry. The services are as follows:

- **AdService**
- **CartService**
- **CheckoutService**
- **CurrencyService**
- **EmailService**
- **Frontend**
- **PaymentService**
- **ProductCatalogService**
- **RecommendationService**
- **ShippingService**
- **ShoppingAssistantService**

For each service:
- **Docker Build**: The microservice is built using a `Dockerfile`.
- **Docker Push**: The built image is pushed to a Docker registry.
- **Docker Cleanup**: The local Docker image is removed after the push to save space.

Example for **AdService**:
```groovy
withDockerRegistry(credentialsId: 'docker-cred', toolName: 'Docker') {
    sh '''
        docker build -t devilcontainer/adservice:latest /var/jenkins_home/workspace/Depi-Pipeline/src/adservice
        docker push devilcontainer/adservice:latest
        docker rmi -f devilcontainer/adservice:latest
    '''
}
```

This process is repeated for all services in parallel, significantly reducing the overall build time.

### 4. Post-Build Notifications
After the build process completes, the pipeline sends a notification to a Slack channel, informing the team of the build's success or failure.

- **On Success**: A success message is sent to the Slack channel.
- **On Failure**: A failure message is sent with a link to the build for further investigation.

```groovy
post {
    success {
        slackSend(channel: 'jenkins', message: "Build succeeded! Everything is ok: ${env.JOB_NAME} #${env.BUILD_NUMBER}")
    }
    failure {
        slackSend(channel: 'jenkins', message: "Build failed! Check the error: ${env.JOB_NAME} #${env.BUILD_NUMBER}")
    }
    always {
        echo 'This will always run, regardless of success or failure.'
    }
}
```

## Pre-requisites
Before using this pipeline, ensure that the following tools are set up and configured:
- **Jenkins**: The Jenkins server must be installed and running.
- **SonarQube**: The SonarQube server should be available for static code analysis.
- **Docker**: Docker must be installed on the Jenkins server for building and pushing images.
- **Slack**: A Slack webhook should be configured to receive notifications.

## Configuration

### Jenkins Configuration
- **SonarQube**: Configure the SonarQube instance in Jenkins.
- **Docker Credentials**: Store the Docker registry credentials under the ID `docker-cred`.
- **Slack Webhook**: Set up the Slack integration and configure the channel to receive notifications.

### Environment Variables
- **SCANNER**: This environment variable is used to define the path to the SonarQube scanner.

```groovy
environment {
    SCANNER = tool 'sonar-scanner'
}
```

## Team

The **Depi-Pipeline** project is managed and maintained by a dedicated team with passion in DevOps, software development, and cloud infrastructure. Our team ensures that the pipeline is efficient, reliable, and scalable to support continuous integration and continuous delivery.

### Team Members:
- **Karim Mohamed**   
  Karim Mohamed is Responsible for overseeing the architecture, implementation, and maintenance of the pipeline
  Karim is the driving force behind the Depi-Pipeline. He is responsible for designing and implementing the pipeline architecture,     
  ensuring it integrates smoothly with Jenkins, Docker, SonarQube, and other essential tools

- **Ahmed Elenany**  
  Ahmed Elenany is responsible for managing the deployment processes within the pipeline. His focus is on ensuring that the microservices are deployed seamlessly across environments, maintaining version control, and handling production releases

- **Habiba Eteam**   
  Habiba Eteam is responsible for The documentation for the entire Project and its processes. She ensures that all technical details, workflows, and guidelines are clearly documented to support team members, contributors, and users plays a supporting role in Continuous Integration (CI) and helped in The implementation of the Pipeline 
  
- **Mohamed Hani**   
 Mohamed Hani is responsible for managing and optimizing the Kubernetes clusters that host the microservices in the Depi-Pipeline. His expertise ensures that the infrastructure remains stable, scalable, and highly available.

- **Mohamed Abo-Bakr**   
 Mohamed Abo-Bakr is responsible for writing comprehensive reports about the Depi-Pipeline project, documenting progress, challenges, and outcomes. His role also includes implementing and managing the Slack integration within the pipeline to enhance team communication.

- **Karim Eteam**   
 Karim Eteam is responsible for managing the deployment processes for the Depi-Pipeline. His primary focus is on managing the Docker, Kubernetes, and cloud deployment infrastructure for the services.
  


## Contribution
Contributions are welcome! If you'd like to contribute to this project, please fork the repository and submit a pull request. For major changes, please open an issue first to discuss what you would like to change.


---
