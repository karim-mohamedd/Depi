<!-- <p align="center">
<img src="/src/frontend/static/icons/Hipster_HeroLogoMaroon.svg" width="300" alt="Online Boutique" />
</p> -->
![Continuous Integration](https://github.com/GoogleCloudPlatform/microservices-demo/workflows/Continuous%20Integration%20-%20Main/Release/badge.svg)

**Online Boutique** is a cloud-first microservices demo application. The application is a web-based e-commerce app where users can browse items, add them to the cart, and purchase them. This demo showcases how developers can modernize enterprise applications using AWS services, including: Amazon EKS (Elastic Kubernetes Service), AWS App Mesh, gRPC, Amazon CloudWatch, Amazon RDS, Amazon ElastiCache, Amazon Aurora, and AWS AI/ML services like Amazon Bedrock. This application works on any Kubernetes cluster.

If you’re using this demo, please ★Star this repository to show your interest!

## Architecture

<img width="1778" alt="architecture-diagram" src="https://github.com/user-attachments/assets/61fa7e60-a8fe-4c4c-aacd-b3e5f2b2c8c8">

**Online Boutique** is composed of 11 microservices written in different languages that communicate with each other over EKS.

### Architecture of Microservices
Find Protocol Buffers Descriptions in the `./protos` directory.

| Service                | Language | Description                                                                                         |
|------------------------|----------|-----------------------------------------------------------------------------------------------------|
| **frontend**           | Go       | Exposes an HTTP server to serve the website. Does not require signup/login and generates session IDs for all users automatically. |
| **cartservice**        | C#       | Stores the items in the user's shopping cart in ElastiCache and retrieves it.                         |
| **productcatalogservice** | Go    | Provides the list of products from a JSON file and the ability to search and retrieve individual products. |
| **currencyservice**    | Node.js  | Converts one money amount to another currency using values fetched from a trusted source. It's the highest QPS service. |
| **paymentservice**     | Node.js  | Charges the given credit card info (mock) with the given amount and returns a transaction ID.        |
| **shippingservice**    | Go       | Gives shipping cost estimates based on the shopping cart and ships items to the given address (mock). |
| **emailservice**       | Python   | Sends users an order confirmation email (mock).                                                     |
| **checkoutservice**    | Go       | Retrieves the user cart, prepares the order, and orchestrates the payment, shipping, and email notification. |
| **recommendationservice** | Python | Recommends other products based on what's in the cart.                                               |
| **adservice**          | Java     | Provides text ads based on given context words.                                                      |
| **loadgenerator**      | Python/Locust | Continuously sends requests imitating realistic user shopping flows to the frontend.           |

## Quickstart (AWS EKS)

Ensure you have the following requirements:
- AWS account.
- Shell environment with AWS CLI, `kubectl`, and `git`.

### 1. Clone the Repository
```bash
git clone --depth 1 --branch v0  https://github.com/karim-mohamedd/Depi
cd microservices-demo/
```

The `--depth 1` argument skips downloading git history.

### 2. Set Up AWS CLI and Environment
Set your AWS region and EKS cluster name:
```bash
export AWS_REGION=us-east-1
export CLUSTER_NAME=online-boutique
```

Ensure the necessary IAM roles and policies are configured, and the EKS service is enabled in your AWS account.

### 3. Create an EKS Cluster
```bash
aws eks create-cluster --name $CLUSTER_NAME --region $AWS_REGION --kubernetes-version 1.21 --role-arn <YOUR_EKS_ROLE_ARN> --resources-vpc-config subnetIds=<YOUR_SUBNETS>,securityGroupIds=<YOUR_SECURITY_GROUP>
```

This may take a few minutes.





## Documentation and Demos Featuring Online Boutique
- **Platform Engineering in Action**: Deploy the Online Boutique sample app using AWS CDK and AWS Proton.
- **Istio on EKS**: Learn how to deploy Online Boutique with Istio-backed service mesh.
- **Use Amazon Aurora**: Deploy Online Boutique with Amazon Aurora for the checkout service database.
- **Secure Your .NET Containers on EKS**: Optimize and secure your .NET containers running on EKS.
- **AI Product Recommendations**: Deploy an AI-powered product recommendation service using Amazon Bedrock.
- **AWS CloudWatch Tracing**: Set up distributed tracing and monitoring with Amazon CloudWatch.




## Team

The **Depi-Project** project is managed and maintained by a dedicated team with passion in DevOps, software development, and cloud infrastructure. Our team ensures that the pipeline is efficient

### Team Members:
- **Karim Mohamed**   
  Karim Mohamed is Responsible for overseeing the architecture, implementation, and maintenance of the pipeline
  Karim is the driving force behind the Depi-Pipeline. He is responsible for designing and implementing the pipeline architecture,     
  ensuring it integrates smoothly with Jenkins, Docker, SonarQube, and other essential tools

- **Ahmed Elenany**  
  Ahmed Elenany is responsible for managing the deployment processes within the pipeline. His focus is on ensuring that the microservices are deployed seamlessly across environments, 
  maintaining version control, and handling production releases

- **Habiba Eteam**   
  Habiba Eteam is responsible for The documentation for the entire Project and its processes. She ensures that all technical details, workflows, and guidelines are clearly documented to 
  support team members, contributors, and users plays a supporting role in Continuous Integration (CI) and helped in The implementation of the Pipeline 
  
- **Mohamed Hani**   
 Mohamed Hani is responsible for managing and optimizing the Kubernetes clusters that host the microservices in the Depi-Pipeline. His expertise ensures that the infrastructure remains 
 stable, scalable, and highly available.

- **Mohamed Abo-Bakr**   
 Mohamed Abo-Bakr is responsible for writing comprehensive reports about the Depi-Pipeline project, documenting progress, challenges, and outcomes. His role also includes implementing 
 and managing the Slack integration within the pipeline to enhance team communication.

- **Karim Eteam**   
 Karim Eteam is responsible for managing the deployment processes for the Depi-Pipeline. His primary focus is on managing the Docker, Kubernetes, and cloud deployment infrastructure for 
 the services.

