# Use a lightweight Ubuntu 20.04 base image
FROM ubuntu:20.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install essential tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl apt-transport-https ca-certificates gnupg2 software-properties-common

# Add the Plex APT repository and its key
RUN curl -s https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add - && \
    echo "deb https://downloads.plex.tv/repo/deb public main" | tee /etc/apt/sources.list.d/plexmediaserver.list

# Update package lists and install Plex Media Server
RUN apt-get update && apt-get install -y plexmediaserver

# Install VA-API utilities and Mesa VA drivers for AMD GPU acceleration
RUN apt-get update && apt-get install -y mesa-va-drivers vainfo libva-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose Plex port (32400 is the default)
EXPOSE 32400

# Create directories for Plex configuration and transcode files
RUN mkdir -p /config /transcode

# Set environment variable so Plex uses /config for its data
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/config

# Run Plex Media Server in no-daemon mode (foreground)
CMD ["/usr/lib/plexmediaserver/Plex Media Server", "--no-daemon"]
