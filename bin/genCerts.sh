mkdir certificates
cd certificates

read -p 'SERVER IP: ' SERVER_IP

openssl genrsa -aes256 -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=manager" -sha256 -new -key server-key.pem -out server.csr

echo "subjectAltName = DNS:manager,IP:${SERVER_IP}" >> extfile.cnf

openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth >> extfile.cnf

openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf
rm -v client.csr server.csr

echo "ca.pem (TLSCACERT)"
cat ca.pem

echo "cert.pem (TLSCERT)"
cat cert.pem

echo "key.pem (TLSKEY)"
cat key.pem
