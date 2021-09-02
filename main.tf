resource "null_resource" "cloudinit_userdata" {
  connection {
    type = var.conn_type
    user = var.conn_user
    host = var.conn_target
  }

  provisioner "file" {
    content = templatefile("${path.module}/templates/userdata.tpl", {
      user_data_blob = yamlencode(var.user_data_blob)
    })
    destination = "${var.snippet_root_dir}/${var.snippet_dir}/user-${var.snippet_file_base}"
  }
}

resource "null_resource" "cloudinit_network" {
  connection {
    type = var.conn_type
    user = var.conn_user
    host = var.conn_target
  }

  provisioner "file" {
    content = templatefile("${path.module}/templates/network.tpl", {
      primary_network = var.primary_network
      extra_networks  = var.extra_networks != null ? var.extra_networks : []
      search_domains  = var.search_domains
      dns_servers     = var.dns_servers
    })
    destination = "${var.snippet_root_dir}/${var.snippet_dir}/network-${var.snippet_file_base}"
  }
}
