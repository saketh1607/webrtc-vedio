#!/bin/sh

# Install dependencies
npm install

# Copy WebRTC adapter file
cp node_modules/webrtc-adapter/out/adapter.js .

# Create cert directory if it doesn't exist
mkdir -p cert

# Generate SSL certificate if it doesn't exist
if [ ! -f cert/cert.pem ]; then
  echo "Generating SSL certificate..."
  # Use proper quoting to avoid path interpretation issues
  openssl req -x509 -nodes -newkey rsa:4096 \
    -keyout cert/key.pem -out cert/cert.pem -days 365 \
    -subj "/C=US/ST=California/L=SanFrancisco/O=MyOrganization/CN=demotest"
fi

# Start the WebSocket server
node server.js