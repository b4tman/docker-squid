[![Drone Build Status](https://cloud.drone.io/api/badges/b4tman/docker-squid/status.svg?ref=refs/heads/master)](https://cloud.drone.io/b4tman/docker-squid)
![Docker Build Status](https://img.shields.io/docker/cloud/build/b4tman/squid)
![Docker Image CI Status](https://github.com/b4tman/docker-squid/workflows/Docker%20Image%20CI/badge.svg)

# docker-squid

Docker Squid container based on Alpine Linux.

Automated builds of the image are available on:

- DockerHub:
  - [b4tman/squid](https://hub.docker.com/r/b4tman/squid)
- Github:
  - [ghcr.io/b4tman/squid](https://github.com/users/b4tman/packages/container/package/squid)
  - [ghcr.io/b4tman/squid-armhf](https://github.com/users/b4tman/packages/container/package/squid-armhf)
  - [ghcr.io/b4tman/squid-ssl-bump](https://github.com/users/b4tman/packages/container/package/squid-ssl-bump)

# Quick Start

Just launch container:

```bash
docker run -p 3128:3128 b4tman/squid
```

or use [docker-compose](https://docs.docker.com/compose/):

```bash
wget https://raw.githubusercontent.com/b4tman/docker-squid/master/docker-compose.yml
docker-compose up
```

# Configuration

## Environment variables:

- **SQUID_CONFIG_FILE**: Specify the configuration file for squid. Defaults to `/etc/squid/squid.conf`.

## Example:

```bash
docker run -p 3128:3128 \
	--env='SQUID_CONFIG_FILE=/etc/squid/my-squid.conf' \
	--volume=/srv/docker/squid/squid.conf:/etc/squid/my-squid.conf:ro \
	b4tman/squid
```

This will start a squid container with your config file `/srv/docker/squid/squid.conf`.
