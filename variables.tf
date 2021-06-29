variable "conn_type" {
  description = "Connection type for the file provisioner."
  type        = string
}

variable "conn_user" {
  description = "Connection user for the file provisioner."
  type        = string
}

variable "conn_target" {
  description = "Connection host for the file provisioner."
  type        = string
}

variable "snippet_dir" {
  default     = "/var/lib/vz"
  description = "Location of the snippet directory."
  type        = string
}

variable "snippet_file_base" {
  description = "Starting stub of the snippet file name."
  type        = string
}

variable "instance_name" {
  description = "Name of the instance (will be used as part of the snippet file name."
  type        = string
}

variable "primary_network" {
  description = "Configuration for the primary network interface (required)."
  type = object({
    gateway = string
    ip      = string
    macaddr = string
    netmask = number
  })
}

variable "extra_networks" {
  description = "Configuration of additional network interfaces."
  type = list(object({
    ips     = list(string)
    macaddr = string
    name    = string
    netmask = number
  }))
}

variable "search_domains" {
  description = "List of search domains."
  type        = list(string)
}

variable "dns_servers" {
  description = "List of DNS servers."
  type        = list(string)
}

variable "user_data_blob" {
  description = "JSON userdata blob which will be written out to templated file directly (as YAML)."
  default     = {}
  type        = map(any)
}
