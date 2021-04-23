#!/bin/bash

# Validate input parameters
if [[ !("$#" -eq 2) ]]; 
    then echo "Parameters missing for puppet enterprise configuration." >&2
    exit 1
fi

# Get parameters
pe_version=$1
console_pw=$2

# Configure for Puppet Enterprise version
pe_url=https://pm.puppetlabs.com/puppet-agent/2019.8.0/6.16.0/repos/deb/focal/puppet6/puppet-agent_6.16.0-1focal_amd64.deb
#pe_url=https://pm.puppetlabs.com/pe-client-tools/2019.8.0/19.8.1/repos/deb/bionic/PC1/pe-client-tools_19.8.1-1bionic_amd64.deb


# Set up variables
pe_tar=${pe_url##*/}
pe_folder=${pe_tar%%.tar.gz}

# Get installation package
cd /tmp; wget -q ${pe_url}

# Unpack installation package
tar -xf ${pe_tar}
cd ${pe_folder}

# Create configuration file
sed '/console_admin_password/c \
   "console_admin_password":"'$console_pw'"' conf.d/pe.conf > conf.d/azure-pe.conf

# Start the installation
sudo ./puppet-enterprise-installer -c conf.d/azure-pe.conf

exit 0
