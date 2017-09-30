#!/bin/bash

CA_name="seryio.es-CA"

#CrypFolder for storing potentially sensitive file
crypFolder="cryp/"

CA_keyFile=$crypFolder$CA_name".key"
CA_cerFile=$crypFolder$CA_name".crt"

#Put a default device name
deviceName="device1"
#Or grab it via CLI
if [ ! -z "$1" ]
then
    deviceName=$1
fi

#Name of the key, CSR (Certificate signing request) and certificate files
device_keyFile=$crypFolder$deviceName".key"
device_csrFile=$crypFolder$deviceName".csr"
device_cerFile=$crypFolder$deviceName".crt"
device_pfxFile=$crypFolder$deviceName".pfx"

#We create a private key of 2048 bytes
openssl genrsa -out $device_keyFile 2048

#We create a signature request to be elavated to the CA for signing
openssl req -new -key $device_keyFile -out $device_csrFile -subj "/C=ES/L=Las Palmas/O=seryio.es/CN="$deviceName".seryio.es"

#Using the private key of the CA, we sign the certificate request and generate a certificate
openssl x509 -req -in $device_csrFile -CA $CA_cerFile -CAkey $CA_keyFile -CAcreateserial -out $device_cerFile -days 500 -sha256

#We deliver a PFX wrapper with private, public key, certificate and CA certificate
<<<<<<< HEAD
openssl pkcs12 -export -out $device_pfxFile -inkey $device_keyFile -in $device_cerFile -certfile $CA_cerFile
=======
openssl pkcs12 -export -out $device_pfxFile -inkey $device_keyFile -in $device_cerFile -certfile $CA_cerFile
>>>>>>> e7d59c310e3728a050178ab59629be17e6850ad6
