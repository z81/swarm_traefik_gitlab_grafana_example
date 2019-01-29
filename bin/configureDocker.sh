mkdir -p /etc/systemd/system/docker.service.d
read -p 'Cert folder path: ' CERT_FOLDER_PATH
echo -e "[Service]\nExecStart=\nExecStart=/usr/bin/dockerd" >> /etc/systemd/system/docker.service.d/exec-start.conf
echo -e "{\n  \"hosts\": [\"tcp://0.0.0.0:2376\",\"fd://\"],\n  \"tlsverify\": true,\n  \"tlscacert\": \"${CERT_FOLDER_PATH}/certificates/ca.pem\",\n  \"tlscert\": \"${CERT_FOLDER_PATH}/certificates/server-cert.pem\",\n  \"tlskey\": \"${CERT_FOLDER_PATH}/certificates/server-key.pem\"\n}" >> /etc/docker/daemon.json
systemctl daemon-reload
service docker restart