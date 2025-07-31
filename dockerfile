FROM n8nio/n8n:latest
USER root
# Install ffmpeg for media processing
RUN if command -v apk > /dev/null; then \
        apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    else \
        echo "Package manager not found" && exit 1; \
    fi

# Install pdf-lib in n8n's node_modules
WORKDIR /usr/local/lib/node_modules/n8n
RUN npm install pdf-lib
WORKDIR /

USER node
