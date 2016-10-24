#!/usr/bin/bash -x
# work in a secure folder
rm -r docker-ca
mkdir docker-ca && chmod 700 docker-ca && cd docker-ca
# generate a key pair for the CA
openssl genrsa -aes256 -out ca-key.pem 2048
# setup CA certificate
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
  # make sure to set CN



# generate a new host key pair
openssl genrsa -out myserver-key.pem 2048
# generate certificate signing request (CSR)
openssl req -subj "/CN=coreos-1.aws.easypages.us" -new -key myserver-key.pem -out myserver.csr
# setup extfile for ip's to allow
#echo "subjectAltName = IP:$myserver_ip, IP:127.0.0.1" >extfile.cnf
echo "" >extfile.cnf
# sign the key by the CA
openssl x509 -req -days 365 -in myserver.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out myserver-cert.pem -extfile extfile.cnf
# test server by updating service:
#/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:2376 --tlsverify \
#  --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/myserver-cert.pem \
#  --tlskey=/etc/docker/myserver-key.pem





# create a client key pair
openssl genrsa -out key.pem 2048
# generate csr for client key
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
# configure request to support client
echo extendedKeyUsage = clientAuth >extfile.cnf
# sign the client key with the CA
openssl x509 -req -days 365 -in client.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out cert.pem -extfile extfile.cnf
# test client with
#docker --tlsverify \
#  --tlscacert=ca.pem --tlscert=client-cert.pem --tlskey=client-key.pem \
#  -H=tcp://127.0.0.1:2376 info`

rm *.csr
rm *.cnf
