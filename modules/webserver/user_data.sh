#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

mkdir -p /var/www-data
mount -o discard,defaults,noatime /dev/disk/by-id/scsi-0DO_Volume_${volume_name} /var/www-data
echo '/dev/disk/by-id/scsi-0DO_Volume_${volume_name} /var/www-data ext4 defaults,nofail,discard 0 0' >> /etc/fstab

mkdir -p /var/www-data/html

apt-get install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

apt-get update
apt-get install -y caddy
systemctl enable --now caddy

cat > /etc/caddy/Caddyfile <<EOF
${domain_name} {
    root * /var/www-data/html
    file_server
}
EOF

chown -R caddy:caddy /var/www-data/html
chmod g+s /var/www-data/html

systemctl restart caddy