# Inception: Dockerized Microservices Infrastructure

[![Tools](https://img.shields.io/badge/Tools-Docker%20%7C%20Compose-2496ED.svg)](https://www.docker.com/)
[![OS](https://img.shields.io/badge/OS-Alpine%20Linux-blue.svg)]()
[![Server](https://img.shields.io/badge/Server-NGINX-green.svg)]()

## Abstract

**Inception** is a System Administration project focused on setting up a robust, containerized infrastructure using **Docker** and **Docker Compose**.

The goal is to architect a small-scale network of loosely coupled microservices strictly following the **Infrastructure as Code (IaC)** principle. Instead of using pre-built images with "magic" automated configurations, each service (NGINX, WordPress, MariaDB) is built from a minimal base OS (Alpine/Debian) via custom `Dockerfiles`, ensuring full control over the configuration files, dependencies, and PID 1 process management.

## System Architecture

The infrastructure consists of three isolated containers communicating over a dedicated internal Docker network, with a single entry point via TLS.

### Services Stack

| Service | Role | Configuration Details |
|:---|:---|:---|
| **NGINX** | **Reverse Proxy & TLS Termination** | Acts as the only entry point (ports 443). Handles TLS v1.2/v1.3 encryption (OpenSSL) and forwards requests to WordPress via FastCGI. |
| **WordPress** | **Application Layer** | Runs PHP-FPM (FastCGI Process Manager). It does not expose any ports to the host, communicating only with NGINX and MariaDB internally. |
| **MariaDB** | **Database Layer** | Persistent data storage. Configured to accept connections only from the WordPress container for enhanced security. |

### Network & Storage
*   **Isolation:** The containers operate within a custom Docker bridge network, preventing external access to the database or application logic directly.
*   **Persistence:** Data is preserved using Docker Volumes mapped to the host machine (`/home/login/data`), ensuring that the database and website content survive container restarts.

## Installation & Setup

### Prerequisites
*   Docker Engine & Docker Compose.
*   `make` utility.
*   Root privileges (required to map volumes to system directories).

### Configuration
1.  Clone the repository.
2.  Create a `.env` file in `srcs/` based on the example provided (if applicable), setting up your environment variables (Database Name, Root Password, Admin User, etc.).

### Deploying the Infrastructure
Use the `Makefile` to build images and orchestrate the containers:

```bash
make
```
*This command creates the required data directories, builds the Docker images from scratch, and launches the network.*

### Accessing the Service
Once up, the application is accessible via HTTPS:
*   URL: `https://localhost` (or the domain configured in your `/etc/hosts`, e.g., `login.42.fr`).
*   *Note: Since the SSL certificate is self-signed for development purposes, your browser will prompt a security warning.*

### Maintenance & Teardown

To stop the containers:
```bash
make stop
```

To clean up containers, networks, and images:
```bash
make clean
```

To perform a full system reset (including persistent data volumes):
```bash
make fclean
```

## Technical Highlights
*   **Security:** No passwords are hardcoded in the Dockerfiles; all credentials are injected via environment variables at runtime.
*   **Efficiency:** Usage of **Alpine Linux** (where possible) to minimize image size and attack surface.
*   **Resilience:** Proper PID handling ensures services can be stopped gracefully (`SIGTERM`).