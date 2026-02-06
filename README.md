# Ops Final: Systems Engineering

This repository holds the clean, production-ready implementation of the infrastructure, along with some Personal labs I did in FreeBSD. The main goal was to build a solid, RHCE-level solution for the cloud environment, but I also used this workspace to practice lower-level systems concepts.

## Project Structure
The project is split into the main automation tools and my systems programming labs.

```text
.
├── Freebsd/                 # Systems Engineering Labs
│   ├── jails_setup          # Virtualization Automation
│   ├── net_*                # Modular Networking Drivers
│   └── *_lab                # Logic & Environment Auditing
├── ansible/                 # Configuration Automation
│   ├── ansible.cfg          # Environment Configuration
│   ├── playbooks/           # State Enforcement
│   └── roles/               # Modular Roles (system_core)
├── terraform/               # Cloud Infrastructure
│   ├── main.tf              # Root Configuration
│   └── modules/             # Resource Abstraction
│       ├── compute/         # Instance Provisioning
│       └── networking/      # Network Architecture
└── README.md                # Technical Documentation
```

## Cloud Infrastructure (Terraform)
This is the modular Terraform setup that provisions my RHEL 10 environment on AWS (`af-south-1`). It's clean and straightforward.

*   **Network**: A custom VPC (`10.0.0.0/16`) to isolate my resources.
*   **Compute**: I use `t3.micro` instances with a specific RHEL 10 AMI.
*   **Security**: Locked down with a specific security group (`rhce-sg`) and key pair access.

## Configuration Management (Ansible)
I use Ansible to ensure the server is configured exactly how I want it, every time.

*   **Users**: Sets up an admin user (`ops_admin`) with `wheel` privileges.
*   **Tools**: Installs the basics I need like `tmux`, `vim`, and `firewalld`.
*   **Storage**: Sets up a 512MB loopback device mounted at `/opt/backup` for storage practice.
*   **Tuning**: Applies a system profile to optimize performance.

## FreeBSD Labs & Shell Logic
The `Freebsd/` directory is where I spent time really getting comfortable with systems logic.

I specifically worked with the FreeBSD `rc.d` system here because it forces you to handle things like signal trapping, process management, and environment parsing manually. It was great practice that really improved my understanding of Bash scripting in general.

*   **Virtualization (Jails)**: I wrote `jails_setup` to automate creating different types of environments—Thick jails, Thin ZFS-backed jails, and NullFS workspaces.
*   **Networking**: I wrote modular scripts (`net_*`) to handle things like static IPs, Wi-Fi connections, and IPv6 router advertisements manually.
*   **Logic Scripts**:
    *   `logic_lab`: This was a playground for handling daemon logic and signal trapping (like catching SIGINT).
    *   `env_lab`: A script to audit and inject environment variables at runtime.
