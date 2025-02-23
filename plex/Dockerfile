# Use the official LinuxServer Plex base image
FROM linuxserver/plex:latest

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential tools (ensure add-apt-repository is available)
RUN apt-get update && apt-get install -y \
    software-properties-common

# Enable the Universe repository (to access libva-utils)
RUN add-apt-repository universe && apt-get update

# Install VA-API packages for AMD GPU acceleration
RUN apt-get update && apt-get install -y \
    mesa-va-drivers \
    vainfo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# (Optional) You can run vainfo here to verify VA-API, but it's not necessary at runtime.
# The CMD is inherited from the base image, so Plex will start normally.
