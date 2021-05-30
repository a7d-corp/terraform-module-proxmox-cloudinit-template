variable "connection_type" {
  type = string
}

variable "connection_user" {
  type = string
}

variable "connection_password" {
  type = string
}

variable "connection_host" {
  type = string
}

variable "snippet_dir" {
  type = string
}

variable "snippet_file_base" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_domain" {
  type = string
}

variable "primary_network_cidr_netmask" {
  type = number
}

variable "primary_ip" {
  type = string
}

variable "primary_ip_gateway" {
  type = string
}

variable "primary_mac" {
  type = string
}

variable "secondary_network_cidr_netmask" {
  type = number
}

variable "secondary_ip" {
  type = string
}

variable "secondary_mac" {
  type = string
}
variable "search_domains" {
  type = list(any)
}

variable "dns_servers" {
  type = list(any)
}
