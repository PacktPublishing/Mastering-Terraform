#!/bin/bash

# Get Ubuntu version
repo_version="22.04"

echo "Repo Version: $repo_version"

# Download Microsoft signing key and repository
url="https://packages.microsoft.com/config/ubuntu/${repo_version}/packages-microsoft-prod.deb"
echo $url
wget $url -O packages-microsoft-prod.deb

# Install Microsoft signing key and repository
dpkg -i packages-microsoft-prod.deb

# Clean up
rm packages-microsoft-prod.deb

# Update packages
apt-get update -y