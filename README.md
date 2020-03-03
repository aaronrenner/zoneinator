# Zoneinator

A sample app that I'm using as a playground.

## Running in docker

This app is set up to run in isolation in a docker container.

1. Building the image: `docker build -t zoneinator:latest .`
2. Migrating the database: `docker run -e DATABASE_URL="ecto://postgres:postgres@host.docker.internal/zoneinator_dev" -e SECRET_KEY_BASE=$(mix phx.gen.secret) -p 4000:4000 --rm zoneinator:latest bin/zoneinator eval "Zoneinator.Release.migrate"`
3. Starting the image: `docker run -e DATABASE_URL="ecto://postgres:postgres@host.docker.internal/zoneinator_dev" -e SECRET_KEY_BASE=$(mix phx.gen.secret) -p 4000:4000 --rm zoneinator:latest bin/zoneinator start`
