# Use a base image of Ubuntu 20.04 LTS
FROM ubuntu:20.04

# Update and install necessary tools
RUN apt-get update && \
    apt-get install -y \
    python3-pip \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install deeptools specifically for Python 3.7
RUN pip3 install deeptools

# Set the working directory
WORKDIR /workspace

# Copy your application scripts
COPY bamCoverage.sh bwCompare.sh edgerbw.sh /scripts/
RUN chmod +x /scripts/bamCoverage.sh /scripts/bwCompare.sh /scripts/edgerbw.sh

# Specify the command to run at container startup
CMD ["/bin/bash"]
