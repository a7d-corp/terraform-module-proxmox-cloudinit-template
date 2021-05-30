locals {
  snippet_dir_path = "/var/lib/vz"
}

resource "null_resource" "cloudinit_userdata" {
  connection {
    type     = var.connection_type
    user     = var.connection_user
    password = var.connection_password
    host     = var.connection_host
  }

  provisioner "file" {
    content = templatefile("${path.module}/templates/userdata.tpl", {
      hostname = "${var.instance_name}.${var.instance_domain}"
    })
    destination = "${local.snippet_dir_path}/${var.snippet_dir}/user-${var.snippet_file_base}"
  }
}

resource "null_resource" "cloudinit_network" {
  connection {
    type     = var.connection_type
    user     = var.connection_user
    password = var.connection_password
    host     = var.connection_host
  }

  provisioner "file" {
    content = templatefile("${path.module}/templates/network.tpl", {
      primary_ip         = "${var.primary_ip}/${var.primary_network_cidr_netmask}"
      primary_ip_gateway = var.primary_ip_gateway
      primary_mac        = var.primary_mac
      secondary_ip       = "${var.secondary_ip}/${var.secondary_network_cidr_netmask}"
      secondary_mac      = var.secondary_mac
      search_domains     = var.search_domains
      dns_servers        = var.dns_servers
    })
    destination = "${local.snippet_dir_path}/${var.snippet_dir}/network-${var.snippet_file_base}"
  }
}
