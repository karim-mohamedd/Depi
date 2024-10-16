# Kubernetes Monitoring with Prometheus and Grafana on Minikube
This is how to set up Prometheus and Grafana for monitoring a Kubernetes cluster running on Minikube. steps for deploying Prometheus to monitor minikube metrics and setting up Grafana to visualize those metrics through custom dashboards.

# Prerequisites
- Minikube installed and running.
- Kubectl installed.
- Helm installed (for Prometheus and Grafana deployment).

# Setup
# Step 1: Start Minikube

First, ensure that Minikube is running:
- minikube start

# Step 2: Install Prometheus using Helm

Add the Prometheus Helm repository:
- helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
- helm repo update

Install the Prometheus stack:
- helm install prometheus prometheus-community/kube-prometheus-stack

Verify that Prometheus components are deployed:
- kubectl get deploy
![Screenshot 2024-10-16 012810](https://github.com/user-attachments/assets/de630ff4-68b1-4459-9328-0bd921eaecfe)

- kubectl get svc
![Screenshot 2024-10-16 182523](https://github.com/user-attachments/assets/9c715239-a632-401d-849b-a6f179fc424a)

# Step 3: Adding a new target
- we can add new target by add a new service monitor and expose it to prometheus
![Screenshot 2024-10-16 182708](https://github.com/user-attachments/assets/b53b242a-0371-45e2-9823-f94c10575429)


# Step 4: Install Grafana using Helm
Grafana is included with the Prometheus Helm chart:

Open the browser and navigate to --> http://<minikube_ip>:<node_port>

The default Grafana login credentials are:

- Username: admin
- Password: admin

# Step 5: Access Prometheus and Grafana Dashboards
Accessing Prometheus by running the following command and then navigating to the URL provided:
kubectl port-forward svc/prometheus-kube-prometheus-prometheus 9090

To access Grafana:

- kubectl port-forward svc/prometheus-grafana 3000

# Step 6: Import Dashboards in Grafana

Once Grafana is up and running:
- Log in using the default credentials.
- Add Prometheus as a data source by providing the URL http://localhost:9090
- Import pre-built dashboards or create custom dashboards to visualize the metrics you are interested in.

# Step 7: Explore Dashboards

Prometheus is now scraping data from minikube, and we can explore that data through Grafana dashboards.

# Sample Dashboard
Import community dashboards like:
- Kubernetes cluster monitoring: Dashboard ID: 6417
- Prometheus Kubernetes Metrics: Dashboard ID: 315

![Screenshot 2024-10-16 005719](https://github.com/user-attachments/assets/a3ae5cc9-8137-4a6b-aaa6-088cecab9aba)

![Screenshot 2024-10-16 010250](https://github.com/user-attachments/assets/1a48d71f-56c0-487f-b57e-32e1020fe373)

# Step 8: Clean Up resourses

To uninstall Prometheus and Grafana:
- helm uninstall prometheus
- minikube stop
