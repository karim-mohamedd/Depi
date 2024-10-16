<!-- <p align="center">
<img src="/src/frontend/static/icons/Hipster_HeroLogoMaroon.svg" width="300" alt="Online Boutique" />
</p> -->
![Continuous Integration](https://github.com/GoogleCloudPlatform/microservices-demo/workflows/Continuous%20Integration%20-%20Main/Release/badge.svg)

**Online Boutique** is a cloud-first microservices demo application. The application is a web-based e-commerce app where users can browse items, add them to the cart, and purchase them. This demo showcases how developers can modernize enterprise applications using AWS services, including: Amazon EKS (Elastic Kubernetes Service), AWS App Mesh, gRPC, Amazon CloudWatch, Amazon RDS, Amazon ElastiCache, Amazon Aurora, and AWS AI/ML services like Amazon Bedrock. This application works on any Kubernetes cluster.

If you’re using this demo, please ★Star this repository to show your interest!

## Architecture

[![Architecture of
microservices](/docs/img/architecture-diagram.png)](/docs/img/architecture-diagram.png)

**Online Boutique** is composed of 11 microservices written in different languages that communicate with each other over gRPC.

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

### 4. Deploy Online Boutique to the Cluster
```bash
kubectl apply -f ./release/kubernetes-manifests.yaml
```

Wait for the pods to be ready:
```bash
kubectl get pods
```

After a few minutes, you should see the Pods in a Running state:

```
NAME                                     READY   STATUS    RESTARTS   AGE
adservice-76bdd69666-ckc5j               1/1     Running   0          2m58s
cartservice-66d497c6b7-dp5jr             1/1     Running   0          2m59s
...
```

### 5. Access the Web Frontend
Get the frontend’s external IP:
```bash
kubectl get service frontend-external | awk '{print $4}'
```

Visit `http://EXTERNAL_IP` in a web browser to access your instance of Online Boutique.

Congrats! You've deployed the Online Boutique application on AWS EKS.

## Additional Deployment Options

- **Terraform**: Follow these [instructions](https://aws-terraform-link) to deploy Online Boutique using Terraform.
- **App Mesh**: Follow these [instructions](https://aws-appmesh-link) to deploy Online Boutique with AWS App Mesh for service-to-service networking.
- **Non-EKS Clusters (Minikube, Kind, etc)**: See the Development guide for deploying Online Boutique on non-EKS clusters.

### Other Customizations
The `/kustomize` directory contains instructions for customizing the deployment of Online Boutique with other variations like Amazon CloudWatch monitoring, encryption, and more.

## Documentation and Demos Featuring Online Boutique
- **Platform Engineering in Action**: Deploy the Online Boutique sample app using AWS CDK and AWS Proton.
- **Istio on EKS**: Learn how to deploy Online Boutique with Istio-backed service mesh.
- **Use Amazon Aurora**: Deploy Online Boutique with Amazon Aurora for the checkout service database.
- **Secure Your .NET Containers on EKS**: Optimize and secure your .NET containers running on EKS.
- **AI Product Recommendations**: Deploy an AI-powered product recommendation service using Amazon Bedrock.
- **AWS CloudWatch Tracing**: Set up distributed tracing and monitoring with Amazon CloudWatch.




## Screenshots of the project

| Home Page                                                                                                         | Checkout Screen                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [![Screenshot of store homepage](/docs/img/online-boutique-frontend-1.png)](/docs/img/online-boutique-frontend-1.png) | [![Screenshot of checkout screen](/docs/img/online-boutique-frontend-2.png)](/docs/img/online-boutique-frontend-2.png) |




