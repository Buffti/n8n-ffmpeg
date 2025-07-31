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

# Create a custom node_modules directory and install pdf-lib there
RUN mkdir -p /usr/local/lib/pdf-lib-custom && \
    cd /usr/local/lib/pdf-lib-custom && \
    npm init -y && \
    npm install pdf-lib

# Create symlink so n8n's VM2 can find it
RUN ln -sf /usr/local/lib/pdf-lib-custom/node_modules/pdf-lib /usr/local/lib/node_modules/pdf-lib

USER node
