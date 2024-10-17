#!/bin/bash
cd /etc/openvpn/easy-rsa/
./easyrsa init-pki # init 
./easyrsa build-ca # create ca

# Create Server Cert
./easyrsa gen-req michael-pham.de nopass

# Generate Diffie-Hellman Code
./easyrsa gen-dh
./easyrsa sign-req server michael-pham.de

cp pki/dh.pem pki/ca.crt pki/issued/michael-pham.de.crt pki/private/michael-pham.de.key /etc/openvpn/


mkdir client
for SERVER in smartpi rpi5 mpham voron0
do
  # Create certificates and sign
  ./easyrsa gen-req $SERVER nopass
  ./easyrsa sign-req client $SERVER
  cp pki/ca.crt client/ca.crt
  cp pki/private/$SERVER.key client/client.key
  cp pki/issued/$SERVER.crt client/client.crt
  cd client
  tar -cf $SERVER.tar client.key client.crt ca.crt
done
rm client/ca.crt client/client.key client/client.crt