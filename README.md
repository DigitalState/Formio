# Formio
Form.io microservice

Before running:
```
docker-compose up
```
Verify the Mongo DSN in docker-compose.yml that Formio is going to use to persisit its data. The current `FORMIO_MONGO_DSN` environment variable points to the IP `10.200.10.1` which you can assign to your loopback interface if you are running mongo on your localhost. Here is how:
```
sudo ifconfig lo0 alias 10.200.10.1/24
```
