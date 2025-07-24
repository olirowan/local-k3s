### Vagrant K3s Cluster

---

A lightweight local Kubernetes cluster built with Vagrant and Ansible using k3s for testing purposes.

##### Quick Start

```bash

# copy and set environment variables
cp env.example .env

# Build cluster
./build.sh

```

<br>

### Overview

---

- **Nodes** (default 3): 
  - `local-kube-101` - 192.168.56.101
  - `local-kube-102` - 192.168.56.102
  - `local-kube-103` - 192.168.56.103
- **K3s Version**: v1.33.1+k3s1
- **OS**: Ubuntu 24.04

<br>

Use the build script, or run manually to build the cluster:

```bash

./build.sh

# or
vagrant up --parallel

```

Access the machines via SSH:

```bash
vagrant ssh local-kube-101 # control plane
vagrant ssh local-kube-102
vagrant ssh local-kube-103
```

Destroy the cluster:

```bash
vagrant destroy -f
```

<br>

### Configuration

---

##### Environment Variables

Sensitive values can be set via environment variables:

- `SERVER_USER_NAME`: ssername to create (default: oli)
- `SERVER_USER_PASSWORD_HASH`: password hash for user
- `SSH_PUBLIC_KEYS`: path to public key (default: _~/.ssh/id_rsa.pub_)
- `NOPASSWD_USER`: user with sudo access (default: oli)


To create a password hash for your user:

```bash
openssl passwd -6 -salt $(openssl rand -base64 6)
```

##### Ansible 

All configuration is in `playbooks/group_vars/`:

- `all.yml`: Common variables for all nodes
- `control_plane.yml`: control plane vars
- `worker.yml`: worker vars

Tags are set as follows:

- `homelab`: Basic system setup (user, packages, SSH)
- `k3s`: K3s installation and configuration 
