#!/bin/bash
#Defines path to the make_config script relative to client-configs.
#Asks user for the name for the config, ex. John
echo What is the name of the user?
read name

#runs ./easyrsa gen-req with the name inputted
cd ~/EasyRSA-3.0.4/
./easyrsa gen-req $name nopass
#copies the key to client-configs/keys
cp pki/private/${name}.key ~/client-configs/keys/
#signs the request
./easyrsa sign-req client $name
#Copies the signed request over to client-configs/keys
cp pki/issued/${name}.crt ~/client-configs/keys/
#copies the ta.key and ca.crt to the same location
cp ta.key ~/client-configs/keys/
cp /etc/openvpn/ca.crt ~/client-configs/keys/
#runs make_config
~/client-configs/make_config.sh $name
