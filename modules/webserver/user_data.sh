#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt-get install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

apt-get update
apt-get install -y caddy
systemctl enable --now caddy

cat > /etc/caddy/Caddyfile <<EOF
${domain_name} {
    root * /var/www
    file_server
}
EOF

mkdir -p /var/www
chown -R caddy:caddy /var/www
chmod g+s /var/www

systemctl restart caddy