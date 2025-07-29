FROM n8nio/n8n:latest

USER root

# Check if we're on Alpine or Debian and install ffmpeg accordingly
RUN if command -v apk > /dev/null; then \
        apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    else \
        echo "Package manager not found" && exit 1; \
    fi

USER node
