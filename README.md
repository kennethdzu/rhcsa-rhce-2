# Ops Final: Advanced Infrastructure Automation

This repository holds a production-ready implementation of a cloud infrastructure and configuration management pipeline. The primary goal was to build a robust, RHCE-level solution for automated environments on AWS.

I also included a set of personal FreeBSD labs where I practice lower-level systems concepts to improve my general shell logic.

## Project Structure
The project is split into the main automation tools and my practice labs.

```text
.
├── ansible/                 # Configuration Automation
│   ├── ansible.cfg          # Environment Configuration
│   ├── playbooks/           # State Enforcement
│   └── roles/               # Modular Roles (system_core)
├── terraform/               # Cloud Infrastructure
│   ├── main.tf              # Root Configuration
│   └── modules/             # Resource Abstraction
│       ├── compute/         # Instance Provisioning
│       └── networking/      # Network Architecture
├── Freebsd/                 # Practice Labs
│   ├── jails_setup          # Virtualization Practice
│   ├── net_*                # Networking Practice
│   └── *_lab                # Logic & Auditing
└── README.md                # Technical Documentation
```

## Cloud Infrastructure (Terraform)
This is the modular Terraform setup that provisions my RHEL 10 environment on AWS (`af-south-1`). It focuses on a clean, maintainable code structure.

*   **Network**: A custom VPC (`10.0.0.0/16`) to isolate my resources.
*   **Compute**: I use `t3.micro` instances with a specific RHEL 10 AMI.
*   **Security**: Locked down with a specific security group (`rhce-sg`) and key pair access.

## Configuration Management (Ansible)
I use Ansible to ensure the server is configured exactly how I want it, every time.

*   **Users**: Sets up an admin user (`ops_admin`) with `wheel` privileges.
*   **Tools**: Installs the basics I need like `tmux`, `vim`, and `firewalld`.
*   **Storage**: Sets up a 512MB loopback device mounted at `/opt/backup` for storage practice.
*   **Tuning**: Applies a system profile to optimize performance.

## Appendix: FreeBSD Practice Labs
The `Freebsd/` directory is where I practice manual systems logic. It's not part of the production pipeline, but it helps me sharpen my understanding of signal trapping and process management.

*   **Service Scripts (`logic_lab`, `env_lab`)**: These are fully compliant `rc.d` scripts. I wrote them to understand how daemons, PID files, and signal traps (`SIGINT`, `SIGTERM`) work under the hood.
*   **Practice Scripts (`jails_setup`, `net_*`)**: These are just for practice. I wrote them to get familiar with manually configuring jails and networking (like static IPs and `wpa_supplicant`) without relying on automation tools.
