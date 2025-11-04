# 🏗️ MLOps & Production Infrastructure

MLOps is the practice of operating, monitoring, and maintaining machine learning systems in production. It's the "ops" in machine learning.

---

## 📚 What You'll Learn

- Containerization with Docker: images, containers, Dockerfiles, multi-stage builds, and best practices
- Cloud platforms (AWS, Google Cloud, Azure): compute, storage, managed ML services, and deployment options
- CI/CD for AI systems: automated testing, model versioning, experiment tracking, and deployment pipelines
- Monitoring and observability: logging, metrics, tracing, model monitoring, and drift detection
- Infrastructure as Code: Terraform, CloudFormation, and reproducible deployments
- Model serving strategies: batch vs real-time inference, serving frameworks, and deployment patterns
- Production workflows: blue-green deployments, canary releases, A/B testing, and rollback procedures

---

## 🔗 Learning Resources

**Prerequisites:**
- [[Stage 2: Working with AI Tools]] - Must have deployed AI applications
- Basic DevOps knowledge (Git, command line, APIs)
- Understanding of cloud computing concepts

**Related Areas:**
- [[Deep Learning Internals & Architecture]] - Understanding what you're deploying
- [[Inference Optimization & Scaling]] - Making deployments efficient
- [[Advanced Evaluation & Testing]] - Production testing strategies

**Key Resources:**
- "Designing Machine Learning Systems" by Chip Huyen
- "Machine Learning Engineering" by Andriy Burkov (free online)
- Google's MLOps documentation
- Cloud provider documentation (AWS SageMaker, Google Vertex AI, Azure ML)
- Made With ML (free, comprehensive MLOps course)

**Tools:**
- Docker and Docker Compose
- GitHub Actions or GitLab CI/CD
- MLflow or Weights & Biases
- Prometheus + Grafana
- Terraform or CloudFormation

---

## Core Domains

### 1. Containerization

**Docker Fundamentals**

What: Lightweight virtualization for consistent environments

Key concepts:
- **Image**: Blueprint (like a class)
- **Container**: Running instance (like an object)
- **Dockerfile**: Instructions to build image
- **Layers**: Incremental build steps

Basic Dockerfile:
```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

Best practices:
- Use specific version tags (not `latest`)
- Multi-stage builds for smaller images
- Minimize layers and size
- Don't run as root
- Use .dockerignore

**Docker Compose**

For multi-container applications:
```yaml
version: '3.8'
services:
  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgres://db:5432/mydb
    depends_on:
      - db
  db:
    image: postgres:15
    environment:
      - POSTGRES_DB=mydb
```

### 2. Cloud Platforms

**AWS for ML**
- **EC2**: Virtual machines (compute)
- **S3**: Object storage (data)
- **SageMaker**: Managed ML service
- **Lambda**: Serverless functions
- **RDS**: Managed databases
- **ECR**: Container registry

**Google Cloud**
- **Compute Engine** (GCE): VMs
- **Vertex AI**: Managed ML platform
- **Cloud Storage**: Object storage
- **Cloud Run**: Serverless containers
- **BigQuery**: Data warehouse

**Azure ML**
- **Virtual Machines**: Compute
- **ML Studio**: Visual builder
- **Endpoints**: Model serving
- **Compute Clusters**: Scalable training

**Choosing a platform**:
- Start with what's easiest
- Consider existing infrastructure
- Lock-in vs portability
- Cost differences (vary by workload)

### 3. CI/CD for AI

**Continuous Integration**

Automated testing:
```yaml
# GitHub Actions example
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
      - run: pip install -r requirements.txt
      - run: pytest
      - run: python -m pylint src/
```

What to test:
- Unit tests (functions work)
- Integration tests (components work together)
- Data validation (data quality)
- Model evaluation (quality metrics)

**Model Versioning**

Track model changes:
```python
# Model registry approach
model_registry = {
    "v1.0": "models/model_v1.pkl",
    "v1.1": "models/model_v1_1.pkl",
    "v2.0": "models/model_v2.pkl"
}

# Load specific version
model = load_model(model_registry["v1.1"])
```

**Experiment Tracking**

Log experiments for reproducibility:
```python
import mlflow

mlflow.start_run()
mlflow.log_param("learning_rate", 0.001)
mlflow.log_metric("accuracy", 0.95)
mlflow.log_artifact("model.pkl")
mlflow.end_run()
```

Tools:
- MLflow
- Weights & Biases
- Neptune
- Tensorboard

### 4. Monitoring & Observability

**Logging**

Three levels:
```python
import logging

logging.debug("Detailed debugging")
logging.info("General information")
logging.warning("Something unexpected")
logging.error("Serious problem")
logging.critical("Cannot continue")
```

Structured logging:
```python
logging.info("Prediction", extra={
    "user_id": 123,
    "model_version": "v1.0",
    "latency_ms": 45
})
```

**Metrics**

Track system health:
```python
from prometheus_client import Counter, Histogram

requests_total = Counter('requests_total', 'Total requests')
request_duration = Histogram('request_duration_seconds', 'Request latency')

requests_total.inc()
with request_duration.time():
    # handle request
```

Metrics to track:
- Request count and latency
- Error rate
- Model latency
- Data quality metrics
- Business metrics

**Model Monitoring**

Detect problems:
- **Data drift**: Input distribution changes
- **Model drift**: Output distribution changes
- **Performance drift**: Accuracy degradation
- Prediction variance changes

Implementation:
```python
def check_data_drift(new_data, baseline):
    """Detect if new data differs from baseline"""
    ks_stat, p_value = ks_2samp(new_data, baseline)
    if p_value < 0.05:
        alert("Data drift detected!")
```

### 5. Infrastructure as Code (IaC)

**Terraform**

Define infrastructure declaratively:
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ml_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "p3.2xlarge"  # GPU instance
  tags = {
    Name = "ML-Server"
  }
}
```

Benefits:
- Version control infrastructure
- Reproducible deployments
- Easy scaling
- Disaster recovery

**CloudFormation** (AWS):
```yaml
Resources:
  MLInstance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: ami-0c55b159cbfafe1f0
      InstanceType: p3.2xlarge
```

### 6. Model Serving

**Batch Inference**
- Process large data periodically
- Cost-effective
- No latency requirements
- Schedule with cron/Airflow

**Real-Time Inference**
- Serve predictions immediately
- API endpoint
- Variable latency requirements
- More expensive

**Options**
- Flask/FastAPI (custom)
- TensorFlow Serving (TensorFlow)
- TorchServe (PyTorch)
- KServe (Kubernetes)
- SageMaker (AWS managed)

Example with FastAPI:
```python
from fastapi import FastAPI
import joblib

app = FastAPI()
model = joblib.load("model.pkl")

@app.post("/predict")
def predict(features: dict):
    prediction = model.predict([features])
    return {"prediction": prediction[0]}
```

### 7. Deployment Strategies

**Blue-Green Deployment**
- Two identical prod environments
- Route traffic to "blue"
- Deploy new version to "green"
- Instant rollback capability

**Canary Deployment**
- Deploy to small percentage first
- Monitor metrics
- Gradually increase traffic
- Roll back if issues detected

**A/B Testing**
- Two versions in production
- Split traffic
- Compare metrics
- Choose winner

## Complete MLOps Workflow

```
Development
   ↓
Version Control (Git)
   ↓
Build Container (Docker)
   ↓
Push to Registry (ECR/GCR)
   ↓
CI Tests (GitHub Actions)
   ↓
Deploy to Staging
   ↓
Integration Tests
   ↓
Deploy to Production (Blue-Green)
   ↓
Monitor (Logging, Metrics, Drift)
   ↓
Alert on Anomalies
   ↓
Rollback if Needed
```

---

## ✅ Learning Checklist

- [ ] Create Dockerfile for ML application
- [ ] Build and push Docker image
- [ ] Deploy container to cloud
- [ ] Set up basic CI/CD pipeline
- [ ] Implement model versioning
- [ ] Track experiments with MLflow
- [ ] Log predictions in production
- [ ] Monitor model performance
- [ ] Detect data drift
- [ ] Implement blue-green deployment
- [ ] Use infrastructure-as-code
- [ ] Set up alerting
- [ ] Implement model rollback
- [ ] Test infrastructure changes

### Production Readiness Checklist

- [ ] Containerized application
- [ ] Automated CI/CD pipeline
- [ ] Model versioning system
- [ ] Experiment tracking
- [ ] Comprehensive logging
- [ ] Metrics and monitoring
- [ ] Drift detection
- [ ] Alerting and on-call
- [ ] Disaster recovery plan
- [ ] Infrastructure-as-code
- [ ] Rollback procedures
- [ ] Security (API keys, secrets)
- [ ] Load testing
- [ ] Documentation

## Next Steps

1. Containerize a trained model
2. Deploy to cloud platform
3. Set up basic monitoring
4. Implement model versioning
5. Build CI/CD pipeline
6. Add drift detection
7. Practice blue-green deployments
8. Write runbooks for common issues
9. Move to [[Inference Optimization & Scaling]]

---

*Last updated: 2025-11-03*
