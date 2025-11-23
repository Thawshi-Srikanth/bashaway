#!/bin/bash
set -e

# =========================
# 0. Stop & remove old container
# =========================
if [ "$(docker ps -aq -f name=^mongo-tls$)" ]; then
    echo "Stopping existing mongo-tls container..."
    docker stop mongo-tls
    echo "Removing existing mongo-tls container..."
    docker rm mongo-tls
fi

# =========================
# 1. Remove previous certificates
# =========================
CERT_DIR="$HOME/mongo-certs"
if [ -d "$CERT_DIR" ]; then
    echo "Removing old certificates from $CERT_DIR..."
    rm -rf "$CERT_DIR"
fi

# =========================
# 2. Create certificate directory securely
# =========================
mkdir -p "$CERT_DIR"
chmod 700 "$CERT_DIR"
echo "Created secure certificate directory: $CERT_DIR"

# =========================
# 3. Generate TLS certificates
# =========================
openssl req -newkey rsa:2048 -nodes \
  -keyout "$CERT_DIR/mongodbkey.key" \
  -x509 -days 365 \
  -out "$CERT_DIR/mongodbkey.crt" \
  -subj "/CN=localhost"

# Combine key + cert for MongoDB
cat "$CERT_DIR/mongodbkey.key" "$CERT_DIR/mongodbkey.crt" > "$CERT_DIR/mongodb.pem"

# Combined CA if any app expects it
cat "$CERT_DIR/mongodbkey.key" "$CERT_DIR/mongodbkey.crt" > "$CERT_DIR/rootCAcombined.pem"

echo "New certificates generated."

# =========================
# 4. Export environment variables
# =========================
export MONGO_TLS_CA_FILE_PATH="$CERT_DIR/mongodbkey.crt"
export MONGO_TLS_CERT_KEY_PATH="$CERT_DIR/mongodb.pem"

echo "Environment variables exported:"
echo "MONGO_TLS_CA_FILE_PATH=$MONGO_TLS_CA_FILE_PATH"
echo "MONGO_TLS_CERT_KEY_PATH=$MONGO_TLS_CERT_KEY_PATH"

# =========================
# 5. Pull MongoDB image
# =========================
docker pull mongodb/mongodb-community-server:latest

# =========================
# 6. Run MongoDB with TLS
# =========================
docker run -d \
  --name mongo-tls \
  -p 27020:27017 \
  -v "$MONGO_TLS_CA_FILE_PATH":/etc/ssl/mongo-ca.crt:ro \
  -v "$MONGO_TLS_CERT_KEY_PATH":/etc/ssl/mongo.pem:ro \
  mongodb/mongodb-community-server:latest \
  --tlsMode requireTLS \
  --tlsCertificateKeyFile /etc/ssl/mongo.pem \
  --tlsCAFile /etc/ssl/mongo-ca.crt

echo "MongoDB is running with TLS on port 27020."
