FROM linuxserver/plex:latest

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install tools needed to add PPAs
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl

# Add the Oibaf PPA for updated Mesa drivers
RUN add-apt-repository -y ppa:oibaf/graphics-drivers && \
    apt-get update && apt-get upgrade -y

# Install VA-API packages for AMD GPU acceleration
RUN apt-get install -y mesa-va-drivers vainfo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables to help VA-API find the driver
ENV LIBVA_DRIVER_NAME=radeonsi
ENV LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri

# Use the default LinuxServer entrypoint
CMD ["/init"]
