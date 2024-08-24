FROM jenkins/ssh-agent:jdk17

RUN apt-get update && apt-get install -y \
    make \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    ca-certificates \
    curl

RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y \
    docker-ce-cli

RUN groupadd docker
RUN usermod -aG docker jenkins