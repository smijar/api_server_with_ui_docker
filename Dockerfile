FROM maven:3.3-jdk-7
  
# Install dependencies
RUN apt-get update && \
    apt-get install -y rpm file mktemp && \
    apt-get clean
 
# prep build users - these match our build slaves environments and avoid UID/ownership issues.
RUN useradd -Ms /bin/bash -u 1000 jenkins && \
    useradd -Ms /bin/bash -u 1001 build

#USER build
