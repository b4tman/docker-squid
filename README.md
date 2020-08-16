[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=b4tman/docker-squid)](https://dependabot.com)
![Docker Build Status](https://img.shields.io/docker/build/b4tman/squid)
![Docker Image CI Status](https://github.com/b4tman/docker-squid/workflows/Docker%20Image%20CI/badge.svg)

# docker-squid

Docker Squid container based on Alpine Linux.

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/b4tman/squid).

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
