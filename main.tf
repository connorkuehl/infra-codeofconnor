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

module "webserver" {
  source = "./modules/webserver"

  do_token     = var.do_token
  ssh_keys     = var.ssh_keys
  region       = var.region
  droplet_name = var.droplet_name
  domain_name  = var.domain_name
}

resource "digitalocean_project" "code_of_connor" {
  name        = "Code of Connor"
  purpose     = "Website or blog"
  description = "My personal blog and website"
}

resource "digitalocean_project_resources" "add_to_project" {
  project = digitalocean_project.code_of_connor.id
  resources = [
    module.webserver.droplet_urn,
    module.webserver.domain_urn,
  ]
}
