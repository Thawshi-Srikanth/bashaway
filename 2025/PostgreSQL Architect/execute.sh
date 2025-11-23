#!/bin/bash
DB_NAME="vectordb"
DB_USER="postgres"
DB_PASS="bashaway2025"
CONTAINER_NAME="postgres-bashaway"
POSTGRES_PORT=5432

sudo apt update
sudo apt install -y gcc make libreadline-dev zlib1g-dev libpq-dev

docker run -d \
    --name $CONTAINER_NAME \
    -e POSTGRES_DB=$DB_NAME \
    -e POSTGRES_USER=$DB_USER \
    -e POSTGRES_PASSWORD=$DB_PASS \
    -p $POSTGRES_PORT:5432 \
    ankane/pgvector

until docker exec $CONTAINER_NAME pg_isready -U $DB_USER > /dev/null 2>&1; do
    sleep 1
done

#dammmmmmm vector extension
docker exec -u $DB_USER $CONTAINER_NAME psql -d $DB_NAME -c "CREATE EXTENSION IF NOT EXISTS vector;"
docker exec -u $DB_USER $CONTAINER_NAME psql -d $DB_NAME -c "DELETE FROM embeddings;"

gcc src/inserter.c -o src/inserter -I/usr/include/postgresql -lpq

src/inserter
