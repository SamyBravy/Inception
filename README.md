# Inception: Docker-based Microservices Infrastructure

[![Infrastructure](https://img.shields.io/badge/Infrastructure-Docker%20Compose-2496ED.svg)](https://docs.docker.com/compose/)
[![Web Server](https://img.shields.io/badge/Server-NGINX-009639.svg)]()
[![Database](https://img.shields.io/badge/Database-MariaDB-003545.svg)]()
[![Caching](https://img.shields.io/badge/Cache-Redis-DC382D.svg)]()

## Abstract

**Inception** is a system administration project focused on building a resilient, containerized infrastructure using **Docker** and **Docker Compose**. The goal is to architect a network of loosely coupled microservices strictly following **Infrastructure as Code (IaC)** principles.

Unlike standard deployments, this project prohibits the use of pre-configured images or automated tools (like `docker network connect`). Every service is built from scratch using custom `Dockerfiles`, ensuring granular control over the OS (Alpine/Debian), PID 1 process management, and configuration files.

## System Architecture

The infrastructure is composed of multiple isolated containers communicating via a dedicated internal bridge network.

| Service | Base OS | Role & Description |
| :--- | :--- | :--- |
| **NGINX** | Alpine | **Reverse Proxy & TLS Termination.** The only entry point (Port 443). Handles SSL/TLS (v1.2/1.3) and forwards requests to WordPress. |
| **MariaDB** | Alpine | **Persistence Layer.** SQL database for WordPress, isolated from the public network. |
| **WordPress** | Debian | **Application Layer.** Running via PHP-FPM (Port 9000). |
| **Redis** | Debian | **Performance Caching.** An object cache configured to optimize WordPress database queries. |
| **FTP** | Debian | **File Transfer.** Vsftpd server allowing direct access to the web server files. |
| **Adminer** | Debian | **Database Management.** Lightweight web interface for managing the MariaDB database. |
| **Netdata** | Debian | **Observability.** Real-time system performance monitoring and metrics visualization. |
| **Static Site** | Debian | **Personal Resume.** A static website server (Node.js/Serve) showcasing the author's CV. |

### Network & Security
*   **Isolation:** All containers reside in the `inception` docker network. Only NGINX exposes port 443 to the host.
*   **Encryption:** Self-signed SSL certificates are generated automatically at build time.
*   **Persistence:** Data for the Database and WordPress is persisted on the host machine via Docker Volumes.

## Prerequisites

*   **Docker Engine** & **Docker Compose**
*   **Make**
*   **Host Configuration:** Map the domain to localhost by adding the following line to your `/etc/hosts` file (replace `sdell-er` with your username if needed):
    ```bash
    127.0.0.1 sdell-er.42.fr
    ```

## Configuration

The project is parameterized via a `.env` file in the `srcs/` directory.

**Environment Variables Structure:**
```env
DOMAIN_NAME=sdell-er.42.fr

# Database Configuration
DB_NAME=wordpress
DB_ROOT=rootpass
DB_USER=wpuser
DB_PASS=wppass
DB_HOST=mariadb

# WordPress Admin
WP_ADMIN_USER=admin
WP_ADMIN_PASS=adminpass
WP_ADMIN_EMAIL=admin@student.42.fr

# FTP Configuration
FTP_USER=ftpuser
FTP_PASS=ftppass
```

## Installation & Orchestration

A `Makefile` is provided to automate the deployment lifecycle.

### Build and Launch
Builds all images from scratch, sets up volumes, and starts the container cluster:
```bash
make all
```

### Stop Services
Stops and removes the running containers:
```bash
make down
```

### System Cleanup
Stops containers, removes images, networks, and Docker volumes (data on host is preserved):
```bash
make clean
```

### Hard Reset
**Warning:** Deletes everything, including persistent data volumes (database and website files) stored in `/home/${USER}/data`:
```bash
make fclean
```

## Accessing Services

Once deployed, the ecosystem is accessible via the following endpoints:

| Service | URL / Access |
| :--- | :--- |
| **WordPress** | `https://sdell-er.42.fr` |
| **Adminer** | `https://sdell-er.42.fr/adminer` |
| **Netdata** | `https://sdell-er.42.fr/netdata/` |
| **Static CV** | `https://sdell-er.42.fr/static/` |
| **FTP** | `ftp://localhost:21` (User/Pass from `.env`) |

## Directory Structure

```plaintext
Inception/
├── Makefile
├── srcs/
│   ├── docker-compose.yml
│   ├── .env
│   └── requirements/
│       ├── mariadb/       # Dockerfile & DB initialization
│       ├── nginx/         # Dockerfile & TLS config
│       ├── wordpress/     # Dockerfile & PHP-FPM config
│       ├── bonus/
│       │   ├── adminer/   # Database GUI
│       │   ├── ftp/       # FTP Server
│       │   ├── netdata/   # System Monitoring
│       │   ├── redis/     # Cache Layer
│       │   └── static/    # Static Website Source
│       └── tools/         # Setup scripts
```