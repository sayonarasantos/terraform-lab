#!/bin/bash


# Install base packages
apt update
apt upgrade -y
apt install -y \
    curl wget mlocate mc tree nano net-tools mtr tldr htop rsync xfsprogs


# Mount data volume
mkfs -t xfs /dev/xvdf
mkdir /data
mount /dev/xvdf /data
chown $USER. -R /data

device_id=$(blkid /dev/xvdf -o export |  awk -F '=' 'NR==2 {print $2}')
echo "UUID=$device_id  /data  xfs  defaults,nofail  0  2" >> /etc/fstab


# Install Docker
curl -fsSL get.docker.com | bash
usermod -aG docker $USER

service docker stop
touch /etc/docker/daemon.json
echo -e "{\n    \"data-root\": \"/data/docker\"\n}" > /etc/docker/daemon.json
mv /var/lib/docker /data/docker
service docker start

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
curl \
    -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose \
    -o /etc/bash_completion.d/docker-compose
