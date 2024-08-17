#!/bin/bash

# Function to log messages

log() {
timestamp=$(date +"%Y-%m-%d %T")
echo "[$timestamp] $1"
}

# Log start of script

log "Starting setup script..."

# Install curl

log "Installing curl..."
sudo apt-get update
sudo apt-get install -y curl
if [ $? -ne 0 ]; then
log "Error: Failed to install curl"
exit 1
fi
log "curl installed successfully"

# Install git

log "Installing git..."
sudo apt-get install -y git
if [ $? -ne 0 ]; then
log "Error: Failed to install git"
exit 1
fi
log "git installed successfully"

# Install docker

log "Installing docker..."
sudo apt-get install -y docker.io
if [ $? -ne 0 ]; then
log "Error: Failed to install docker"
exit 1
fi
log "docker installed successfully"

# Install docker-compose

log "Installing docker-compose..."
sudo apt-get install -y docker-compose
if [ $? -ne 0 ]; then
log "Error: Failed to install docker-compose"
exit 1
fi
log "docker-compose installed successfully"

# Add user to docker group

log "Adding user to docker group..."
sudo usermod -aG docker $USER
if [ $? -ne 0 ]; then
log "Error: Failed to add user to docker group"
exit 1
fi
log "User added to docker group successfully"


#more install resource to install docker
log "Installing docker-extra_resource_update..."
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
if [ $? -ne 0 ]; then
log "Error: Failed to install docker-extra_resource_update"
exit 1
fi
log "docker-extra_resource_update installed successfully"
