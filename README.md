# Decentralized Home Computing Network

## Overview
The **Decentralized Home Computing Network (HCN)** leverages Kubernetes clusters to transform idle computing resources into scalable Infrastructure as a Service (IaaS), Platform as a Service (PaaS), and Software as a Service (SaaS) solutions. This project is designed to address inefficiencies in centralized computing by enabling resource monetization and optimizing utilization in home environments.

---

## Key Features

- **Decentralization:** Uses distributed computing resources such as PCs, Raspberry Pis, and outdated systems.
- **Resource Monetization:** Generate passive income by offering IaaS, PaaS, and SaaS solutions.
- **Scalability:** Automatically manage tasks with Kubernetes, ensuring smooth operation under varying workloads.
- **Containerization:** Employs Docker to run lightweight, portable containers.
- **Accessibility:** Supports VNC and ttyd for remote system and desktop access.

---

## Project Objectives

- Optimize resource utilization by leveraging unused computing power in home environments.
- Generate passive income through monetized computing services.
- Establish a secure and efficient decentralized network for task orchestration.
- Integrate scalable cloud computing models (IaaS, PaaS, SaaS) within home networks.

---

## Getting Started

### Prerequisites

1. **Hardware:** A system capable of running Kubernetes (e.g., modern desktops, old laptops, Raspberry Pis).
2. **Software:**
   - Kubernetes (K3s recommended for lightweight environments)
   - Docker for containerization
3. **Network:** Stable home internet connection (recommended speed ≥200 Mbps).

### Node Setup
To add a node to the cluster, execute the following command:
```bash
curl -sfL https://get.k3s.io | K3S_TOKEN="YOURTOKEN" K3S_URL="https://[your server]:6443" K3S_NODE_NAME="servername" sh -
```
Replace `YOURTOKEN`, `[your server]`, and `servername` with appropriate values.

---

## Income Generation Strategies

1. **Infrastructure as a Service (IaaS):**
   - Offer virtual machines on Kubernetes worker nodes.
   - Example: Web-based terminal access with ttyd, desktop access via VNC.

2. **Platform as a Service (PaaS):**
   - Provide platforms for clients to develop and deploy containerized applications.
   - Example: Custom web hosting environments.

3. **Software as a Service (SaaS):**
   - Deploy software applications on worker nodes for subscription-based access.
   - Example: NextCloud, WordPress.

---

## Architecture

### Control Plane
- High-capacity system managing all worker nodes.
- Automates scaling, deployment, and monitoring.

### Worker Nodes
- Run Kubernetes-supported Linux distributions.
- Configurable with various hardware specifications (e.g., modern and legacy systems).
- Globally distributed nodes contribute to the decentralized cluster.

---

## Experimental Results

### Setup
- Hardware:
  - **Node 1:** 8GB RAM, i7 9th gen, 1.5TB SSD.
  - **Node 2:** 4GB RAM, i5 5th gen, 1TB HDD.
- Software:
  - Kubernetes (K3s v1.27.7)
  - Docker (v20.10.25)
- Network: 200 Mbps internet speed.

### Performance Metrics

| Metric                     | 2 Nodes         | 3 Nodes         |
|----------------------------|-----------------|-----------------|
| **Latency**                | 180 ms         | 140 ms         |
| **Throughput**             | 70 requests/sec | 110 requests/sec |
| **CPU Usage (Data Processing)** | 85%            | 80%             |
| **CPU Usage (Web Hosting)**    | 65%            | 60%             |

---

## Passive Income Example

1. Use **ntfy.sh** to receive notifications for earnings:
   - `curl -d "Passive income notification: $AMOUNT earned." https://ntfy.sh/YOUR_TOPIC`

2. Earnings Calculation (Pseudocode):
   - **Script A:** Collect system info and save as CSV.
   - **Script B:** Format data for analysis.
   - **Script C:** Calculate and display total earnings.
   - **Script D:** Compute monthly income projections.

---

## Future Enhancements

- Enhance security measures for distributed networks.
- Implement machine learning workload support.
- Develop intuitive dashboards for node monitoring and income analytics.
- Expand documentation for broader community adoption.

---

## Contributions
Contributions are welcome! Please fork the repository and submit a pull request with your proposed changes.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Acknowledgments

- Supported by the Department of Computer Applications, PES University, Bangalore, India.
- Inspired by advancements in Kubernetes, Docker, and decentralized computing technologies.

---

For inquiries or collaborations, contact **Rahul Rajar** at [rahulraj_2001@hotmail.com](mailto:rahulraj_2001@hotmail.com).
