echo "Create user"
sudo adduser deployer
sudo groupadd docker
sudo usermod -aG docker deployer

echo -e "\necho \"Generate ssh key\"\nssh-keygen -t rsa\ncp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys\necho \"ssh key\"\ncat ~/.ssh/id_rsa" >> /home/deployer/genereateKey__.sh
chmod +x /home/deployer/genereateKey__.sh
su -c "~/genereateKey__.sh" deployer
rm /home/deployer/genereateKey__.sh