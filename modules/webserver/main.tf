terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_volume" "www_data" {
  region                  = var.region
  name                    = "www-data"
  size                    = 5
  initial_filesystem_type = "ext4"
  description             = "Content for the webserver to serve"
}

resource "digitalocean_droplet" "www" {
  image  = "ubuntu-20-04-x64"
  name   = var.droplet_name
  region = var.region
  size   = var.size_slug

  ssh_keys = var.ssh_keys
  user_data = templatefile("${path.module}/user_data.sh", {
    domain_name = var.domain_name
    volume_name = digitalocean_volume.www_data.name
  })
}

resource "digitalocean_volume_attachment" "attach_www_data_to_www" {
  droplet_id = digitalocean_droplet.www.id
  volume_id  = digitalocean_volume.www_data.id
}

resource "digitalocean_domain" "a_record" {
  name       = var.domain_name
  ip_address = digitalocean_droplet.www.ipv4_address
}