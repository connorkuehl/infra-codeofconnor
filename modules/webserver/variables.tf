variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "ssh_keys" {
  type        = list(any)
  description = "SSH keys that may access the droplet"
  default     = []
}

variable "size_slug" {
  type        = string
  description = "DigitalOcean droplet size slug"
  default     = "s-1vcpu-1gb"
}

variable "region" {
  type        = string
  description = "DigitalOcean region"
}

variable "droplet_name" {
  type        = string
  description = "Human-readable name for the droplet"
  default     = "www"
}

variable "domain_name" {
  type        = string
  description = "A record to assign to the webserver droplet"
}
