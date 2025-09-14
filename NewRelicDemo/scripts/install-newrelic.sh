#!/bin/bash
# Simple script to install and configure New Relic Infrastructure Agent

# ===== Variables =====
# Replace with your New Relic license key
NEW_RELIC_LICENSE_KEY="YOUR_LICENSE_KEY"
NEW_RELIC_REGION="US"   # Change to EU if needed

# ===== Detect OS =====
if [ -f /etc/debian_version ]; then
    OS="debian"
elif [ -f /etc/redhat-release ]; then
    OS="rhel"
else
    echo "Unsupported OS. Exiting."
    exit 1
fi

# ===== Install Agent =====
if [ "$OS" == "debian" ]; then
    echo "Installing New Relic agent on Debian/Ubuntu..."
    curl -Ls https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo apt-key add -
    printf "deb [arch=amd64] https://download.newrelic.com/infrastructure_agent/linux/apt jammy main\n" | sudo tee /etc/apt/sources.list.d/newrelic-infra.list
    sudo apt-get update
    sudo apt-get install -y newrelic-infra
elif [ "$OS" == "rhel" ]; then
    echo "Installing New Relic agent on RHEL/CentOS..."
    sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
    sudo yum install -y newrelic-infra
fi

# ===== Configure Agent =====
echo "license_key: $NEW_RELIC_LICENSE_KEY" | sudo tee /etc/newrelic-infra.yml
echo "region: $NEW_RELIC_REGION" | sudo tee -a /etc/newrelic-infra.yml

# ===== Restart Agent =====
sudo systemctl enable newrelic-infra
sudo systemctl restart newrelic-infra

# ===== Verify =====
echo "Checking New Relic agent status..."
sudo systemctl status newrelic-infra --no-pager

echo "✅ New Relic Infrastructure agent installed and configured!"


