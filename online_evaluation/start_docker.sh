#!/bin/bash

# Change permissions for postgres_data and grafana_data directories
sudo chmod -R 755 ./postgres_data
sudo chmod -R 755 ./grafana_data

# Run docker-compose up with build
docker-compose up --build