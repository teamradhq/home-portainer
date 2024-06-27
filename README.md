# Home Portainer

This is a repo to provide a Portainer interface for managing Docker containers on a home network.

It provides two stacks:

1. Portainer Server: The main instance of the service.
2. Portainer Agent: Deployed on any other docker hosts you want to connect to the server.

## Quickstart

### Server

Start a server:

```bash
docker compose up -d
```

Verify by visiting `http?s://localhost:9000`.

### Agent

Start an agent:

```bash
docker compose -f  up -d docker-compose-agent.yml
```

Verify by visiting `http?s://localhost:9001`.

## Configure Systemd Service

There are scripts for defining a systemd service for the server and agent in the `bin` directory.

### Server

Configure the `portainer-server` service:

```bash
./bin/install-portainer-server-service.sh $USER $WORKDIR
```

Interact with the service: 

```bash
sudo systemctl start portainer-server
sudo systemctl stop portainer-server
sudo systemctl reload portainer-server
sudo systemctl status portainer-server
```

### Agent

Configure the `portainer-agent` service:

```bash
./bin/install-portainer-agent-service.sh $USER $WORKDIR
```

Interact with the service: 

```bash
sudo systemctl start portainer-agent
sudo systemctl stop portainer-agent
sudo systemctl reload portainer-agent
sudo systemctl status portainer-agent
```

