#!/bin/bash

PUBKEYPATH="/tmp/host-id_rsa.pub" # Temporary buffer file to deploy host public key 
MAINUSER="vagrant"
AUTHKEYFILE="/home/$MAINUSER/.ssh/authorized_keys"

apt install -y ansible

# Deploying host public key
# Trying to make this idempotent
if [[ -f $PUBKEYPATH ]]; then
  echo "Host public key found at $PUBKEYPATH"
  
  # If there's only one authorized key, we must install ours.
  if [[ $(sudo -i -u $MAINUSER wc -l $AUTHKEYFILE | cut -f1 -d " ") -lt 2 ]]; then
    echo "Deploying pubkey" && cat $PUBKEYPATH >> $AUTHKEYFILE
  else 
    echo "Pubkey not deployed"
  fi
else
  echo "Host public key NOT found. Expected name was \'$PUBKEYPATH\'"
fi

