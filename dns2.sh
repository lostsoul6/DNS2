#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Disable and stop systemd-resolved
systemctl disable --now systemd-resolved

# Remove existing resolv.conf
rm /etc/resolv.conf

# Create new resolv.conf with specified nameservers
echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4" > /etc/resolv.conf

# Make resolv.conf immutable
chattr +i /etc/resolv.conf
