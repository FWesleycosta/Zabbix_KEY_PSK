#!/bin/bash

# Generate PSK key
psk=$(openssl rand -hex 32)

# Create PSK key directory
mkdir -p /etc/zabbix/psk

# Write PSK key to file
echo $psk > /etc/zabbix/psk/psk.txt

# Add PSK settings to agent configuration file
echo "TLSConnect=psk" >> /etc/zabbix/zabbix_agentd.conf
echo "TLSPSKIdentity=$HOSTNAME" >> /etc/zabbix/zabbix_agentd.conf
echo "TLSPSKFile=/etc/zabbix/psk/psk.txt" >> /etc/zabbix/zabbix_agentd.conf
echo "TLSAccept=psk" >> /etc/zabbix/zabbix_agentd.conf

# Restart agent
systemctl restart zabbix-agent

# Print PSK key and identity name
echo "Generated PSK key: $psk"
echo "TLSPSKIdentity: $HOSTNAME"
