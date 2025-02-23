# Use the official LinuxServer Plex base image
FROM linuxserver/plex:latest

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential utilities and software-properties-common for adding PPAs
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl

# Add the Oibaf PPA to get newer Mesa drivers
RUN add-apt-repository -y ppa:oibaf/graphics-drivers && \
    apt-get update && apt-get upgrade -y

# Install updated Mesa VA-API packages and VA-API utilities
RUN apt-get install -y mesa-va-drivers vainfo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set VA-API environment variables so the system uses the radeonsi driver
ENV LIBVA_DRIVER_NAME=radeonsi
ENV LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri

# For testing, you can override the entrypoint to run a VA-API test:
# Uncomment the following line to run vainfo on container startup:
#CMD ["vainfo", "--display", "drm", "--device", "/dev/dri/card0"]

# Once confirmed working, revert to the original entrypoint:
CMD ["/init"]
