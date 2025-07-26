# Start from the official n8n image (ensure you use a tag that suits your needs, e.g., n8nio/n8n:latest or a specific version)
FROM n8nio/n8n:latest

# Switch to root user to install system packages
USER root

# Update package lists and install ffmpeg using apk
# --no-cache to avoid installing unnecessary packages
RUN apk update && \
    apk add --no-cache ffmpeg && \
    rm -rf /var/cache/apk/*

# Switch back to the 'node' user that n8n runs as
USER node
