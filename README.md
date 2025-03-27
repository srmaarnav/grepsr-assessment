# Grepsr Assessment

## Overview
This project is a FastAPI-based application that tracks the number of requests made to a specific endpoint. It includes a Helm chart for Kubernetes deployment and a vanilla Kubernetes manifest for direct deployment.

## Features
- FastAPI application to count requests.
- PostgreSQL database integration.
- Kubernetes deployment using Helm and vanilla manifests.
- Tested on a local Minikube cluster.
- Configurable via environment variables.

## Prerequisites
- Python 3.8 or higher
- PostgreSQL
- Kubernetes cluster (Minikube recommended)
- Helm 3.x
- Docker

## Setup

### Local Development
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/grepsr-assessment.git
   cd grepsr-assessment
   ```

2. Create a virtual environment and activate it:
   ```bash
   python -m venv venv
   source venv/bin/activate  
   On Windows use `venv\Scripts\activate`
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Set up environment variables in a `.env` file:
   ```env
   DATABASE_URL=postgresql://<username>:<password>@<host>:<port>/<database>
   ```

5. Run the application:
   ```bash
   uvicorn app.main:app --reload
   ```

6. Access the API at `http://127.0.0.1:8000/count`.

### Kubernetes Deployment

#### Using Helm
1. Build and push the Docker image:
   ```bash
   docker build -t <your-dockerhub-username>/fastapi-assesment-app:latest .
   docker push <your-dockerhub-username>/fastapi-assesment-app:latest
   ```

2. Update the Helm chart values in `helm/helm-count-app/values.yaml`:
   - Set `image.repository` to your Docker Hub repository.
   - Update `DATABASE_URL` under `env`.

3. Deploy the application:
   ```bash
   helm install count-app helm/helm-count-app
   ```

4. Verify the deployment:
   ```bash
   kubectl get pods
   kubectl get svc
   ```

5. Access the application using the NodePort or Ingress (if enabled).

#### Using Vanilla Kubernetes Manifests
1. Navigate to the `kubernetes-manifest` directory:
   ```bash
   cd kubernetes-manifest
   ```

2. Apply the manifests:
   ```bash
   kubectl apply -f .
   ```

3. Verify the deployment:
   ```bash
   kubectl get pods
   kubectl get svc
   ```

4. Access the application using the NodePort or Ingress (if enabled).

### Minikube Usage
- This project was tested on a local Minikube cluster.
- To start Minikube:
  ```bash
  minikube start
  ```
- To access the application via Minikube's NodePort:
  ```bash
  minikube service <service-name>
  ```

## Testing
Run the application locally and make requests to the `/count` endpoint to verify the request counter functionality.

## Folder Structure
- `/count-app`: Contains the FastAPI application.
- `/helm`: Contains the Helm chart for Kubernetes deployment.
- `/kubernetes-manifest`: Contains vanilla Kubernetes manifests for deployment.
