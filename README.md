# terraform-module-proxmox-cloudinit-template

Terraform module to template out cloudinit files to Proxmox hosts.


## Limitations

This module can only template cloudinit config files out to a single host. To get around this I use an NFS mount on all hosts with `snippets` enabled. That way you can template out to a single host in your cluster irrespective on the host you want to land the instance on.

## Variables

| name                      | type         | required | description                      |
|---------------------------|--------------|----------|----------------------------------|
| `conn_target`             | string       | `true`   | Host to provision the cloudinit files to (see the [Terraform docs](https://www.terraform.io/docs/language/resources/provisioners/connection.html)). |
| `conn_type`               | string       | `true`   | File provisioner connection type (see the [Terraform docs](https://www.terraform.io/docs/language/resources/provisioners/connection.html)). |
| `conn_user`               | string       | `true`   | User to connect as (see the [Terraform docs](https://www.terraform.io/docs/language/resources/provisioners/connection.html)). |
| `conn_host_key`           | string       | `true`   | SSH pub key of connection target (see the [Terraform docs](https://www.terraform.io/docs/language/resources/provisioners/connection.html)). |
| `dns_servers`             | list(string) | `true`   | List of DNS servers.             |
| `extra_networks`          | list(object) | `false`  | List of objects which represent additional network interfaces. Can be repeated `n` times. |
| `extra_networks.ips`      | list(string) | `false`  | List of IPs to assign to the interface |
| `extra_networks.macaddr`  | string       | `false`  | MAC address for the interface.   |
| `extra_networks.name`     | string       | `false`  | Device ID (see the [Cloudinit docs](https://cloudinit.readthedocs.io/en/latest/topics/network-config-format-v2.html#device-configuration-ids)). |
| `extra_networks.netmask`  | number       | `false`  | Netmask in CIDR notation (e.g `24`). |
| `instance_name`           | string       | `true`   | Name of the instance which will consume the cloudinit files. |
| `primary_network`         | object       | `true`   | Object which describes the primary network interface. |
| `primary_network.gateway` | string       | `true`   | Gateway IP for the interface.    |
| `primary_network.ip`      | string       | `true`   | IP address for the interface in dotted octet notation (e.g. `192.168.1.2`). |
| `primary_network.macaddr` | string       | `true`   | MAC address for the interface.   |
| `primary_network.netmask` | number       | `true`   | Netmask in CIDR notation (e.g `24`). |
| `search_domains`          | list(string) | `true`   | List of search domains.          |
| `snippet_dir`             | string       | `true`   | Path to the snippets dir on the target host (see the [Proxmox docs](https://pve.proxmox.com/wiki/Storage)) |
| `snippet_file_base`       | string       | `true`   | Opening stub of the templated file names (must be unique to avoid collisions). |
| `user_data_blob`          | map(any)     | `false`  | Cloudinit userdata in YAML format - must be valid YAML (see the [Cloudinit docs](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)). |

## Outputs

| name         | type   | description                   |
|--------------|--------|-------------------------------|
| `primary_ip` | string | The primary IP of the server. |

## Sample config

```hcl
module "cloudinit_template" {
  source = "github.com/glitchcrab/terraform-module-proxmox-cloudinit-template"

  conn_type         = "ssh"
  conn_user         = "root"
  conn_target       = "proxmox-host.domain.com"
  conn_host_key     = "AAAAC3NzaC1lZDI1NTE5AAAAIO6GRJ4+I//VifkqcA3fEG38uFp95t+gQXyQivmUDxHy"
  snippet_dir       = "/var/lib/vz"
  snippet_file_base = "my-instance"

  instance_name   = "my-instance"

  primary_network = {
    gateway = "172.16.0.1"
    ip      = "172.16.0.100"
    macaddr = "00:00:00:00:00:00"
    netmask = 24
  }

  extra_networks = [{
    ips     = ["192.16.1.100"]
    macaddr = "00:00:00:00:00:11"
    name    = "eth1"
    netmask = 24
  }, {
    ips     = ["10.1.1.100", "10.1.1.200"]
    macaddr = "00:00:00:00:00:22"
    name    = "eth2"
    netmask = 20
  }]

  search_domains = ["domain.com"]
  dns_servers    = ["1.1.1.1"]

  user_data_blob = {
    hostname: "my-instance.domain.com"
  }
}
```
