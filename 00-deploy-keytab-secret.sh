#!/bin/bash
#Define a set of environment variables to be used in resource creations.
#

sudo su
apt-get update # Update for latest package
DEBIAN_FRONTEND=noninteractive apt-get -yq install krb5-user # Unattended krb5-user install
mv /etc/krb5.conf /etc/krb5.conf.example # Backup useless file
echo -e "[libdefaults]\ndefault_realm = CONTOSO.LOCAL\ndns_lookup_realm = true\ndns_lookup_kdc = true" > /etc/krb5.conf # Pass in realm information for ktutil

# Arc keytab creation script
mkdir azure-arc
cd azure-arc
# Download script from github
wget https://raw.githubusercontent.com/microsoft/azure_arc/main/arc_data_services/deploy/scripts/create-sql-keytab.sh
chmod u+x create-sql-keytab.sh # Change permissions to execute

################################
# Run script for keytab creation
################################
# AD_PASSWORD is the password for the SQL MI User we created in AD earlier
AD_PASSWORD=arcadmin@123 ./create-sql-keytab.sh \
   --realm CONTOSO.LOCAL \
   --account arcuser \
   --port 31433 \
   --dns-name azdc01.contoso.local \
   --keytab-file arcuser.keytab \
   --secret-name arcuser-keytab-secret \
   --secret-namespace arc