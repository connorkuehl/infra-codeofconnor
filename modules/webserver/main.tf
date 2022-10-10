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

resource "digitalocean_droplet" "webserver" {
  image  = "ubuntu-20-04-x64"
  name   = var.droplet_name
  region = var.region
  size   = var.size_slug

  ssh_keys = var.ssh_keys
  user_data = templatefile("${path.module}/user_data.sh", {
    domain_name = var.domain_name
  })
}

resource "digitalocean_domain" "a_record" {
  name       = var.domain_name
  ip_address = digitalocean_droplet.webserver.ipv4_address
}