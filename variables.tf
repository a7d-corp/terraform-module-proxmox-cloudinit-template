variable "conn_type" {
  type = string
}

variable "conn_user" {
  type = string
}

variable "conn_target" {
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
