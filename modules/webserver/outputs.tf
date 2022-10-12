output "droplet_urn" {
  value = digitalocean_droplet.www.urn
}

output "domain_urn" {
  value = digitalocean_domain.a_record.urn
}

output "volume_urn" {
  value = digitalocean_volume.www_data.urn
}