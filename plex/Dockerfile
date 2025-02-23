# Use a lightweight Ubuntu 20.04 base image
FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install essential utilities
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl apt-transport-https ca-certificates gnupg2 software-properties-common

# Add the Plex repository key and repository
RUN curl -s https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add - && \
    echo "deb https://downloads.plex.tv/repo/deb public main" | tee /etc/apt/sources.list.d/plexmediaserver.list

# **Enable the Universe repository**
RUN add-apt-repository universe

# Update package lists and install Plex Media Server
RUN apt-get update && apt-get install -y plexmediaserver

# Install VA-API packages and tools for AMD GPU acceleration
RUN apt-get update && apt-get install -y mesa-va-drivers vainfo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create directories for Plex configuration and transcode files
RUN mkdir -p /config /transcode

# Set environment variable so Plex uses /config for its metadata
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/config

# Expose Plex port
EXPOSE 32400

# Run Plex in the foreground (no daemon mode)
CMD ["/usr/lib/plexmediaserver/Plex Media Server", "--no-daemon"]
