data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    user_data_blob = var.user_data_blob
  }
}

resource "null_resource" "cloudinit_userdata" {
  connection {
    type        = var.conn_type
    user        = var.conn_user
    private_key = base64decode(var.conn_ssh_key)
    host        = var.conn_target
  }

  provisioner "file" {
    content     = "${data.template_file.userdata.rendered}"
    destination = "${var.snippet_root_dir}/${var.snippet_dir}/user-${var.snippet_file_base}"
  }
}

data "template_file" "network" {
  template = "${file("${path.module}/templates/network.tpl")}"

  vars {
    primary_network = var.primary_network
    extra_networks  = var.extra_networks != null ? var.extra_networks : []
    search_domains  = var.search_domains
    dns_servers     = var.dns_servers
  }
}

resource "null_resource" "cloudinit_network" {
  connection {
    type        = var.conn_type
    user        = var.conn_user
    private_key = base64decode(var.conn_ssh_key)
    host        = var.conn_target
  }

  provisioner "file" {
    content     = "${data.template_file.network.rendered}"
    destination = "${var.snippet_root_dir}/${var.snippet_dir}/network-${var.snippet_file_base}"
  }
}
