# Docker

The DigitalState Formio microservice docker information.

## Table of Contents

- [Environment Variables](#environment-variables)

## Environment Variables

| Name | Description | Default |
| :--- | :---------- | :------ |
| `COMPOSE_PROJECT_NAME` | The docker-compose project name. This is used to properly namespace docker containers in the event where you are running multiple instances of the platform on the same machine. | `dsformio` |
| `NETWORK` | The docker network name containers uses for microservices communication. | `dsproxy_default` |
| `DIRECTORY` | The base directory the docker-compose files are located. This is used to properly configure the base directory for DockerForWindows and DockerForMac based machines. | `.` |
| `IMAGE_TAG` | The dockerhub image tag to pull for dev, stag and prod environments. | `0.8.0` |
| `API_HOST` | The virtual host for the api container. This value gets registered with the [proxy](https://github.com/DigitalState/Proxy). | `api.formio.ds` |
| `DATABASE_UI_HOST` | The virtual host for the database ui container. This value gets registered with the [proxy](https://github.com/DigitalState/Proxy). | `ui.database.formio.ds` |
| `USERNAME` | The default username for the administrator. | `admin` |
| `PASSWORD` | The default password for the administrator. | `admin` |
| `FORMIO_DEFAULT_JSON` | The default formio configurations. | `{"mongoSecret":"OVERRIDDEN_MONGO_SECRET", "jwt": {"secret": "OVERRIDDEN_JWT_SECRET", "expireTime": 86400}}` |
