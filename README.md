# terraform-module-proxmox-cloudinit-template

Terraform module to template out cloudinit files to Proxmox hosts.


## Limitations

This module can only template cloudinit config files out to a single host. To get around this I use an NFS mount on all hosts with `snippets` enabled. That way you can template out to a single host in your cluster irrespective on the host you want to land the instance on.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |

## Providers

| Name | Version |
|------|---------|
| null | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.cloudinit_network](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.cloudinit_userdata](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| conn_ssh_key | String containing a base64 encoded SSH private key. | `string` | yes |
| conn_target | Connection host for the file provisioner. | `string` | yes |
| conn_type | Connection type for the file provisioner. | `string` | yes |
| conn_user | Connection user for the file provisioner. | `string` | yes |
| dns_servers | List of DNS servers. | `list(string)` | yes |
| instance_name | Name of the instance (will be used as part of the snippet file name. | `string` | yes |
| primary_network | Configuration for the primary network interface (required). | <pre>object({<br>    gateway = string<br>    ip      = string<br>    macaddr = string<br>    name    = string<br>    netmask = number<br>  })</pre> | yes |
| search_domains | List of search domains. | `list(string)` | yes |
| snippet_file_base | Starting stub of the snippet file name. | `string` | yes |
| extra_networks | Configuration of additional network interfaces. | `any` | no |
| snippet_dir | n/a | `string` | no |
| snippet_root_dir | Location of the snippet directory. | `string` | no |
| user_data_blob | Userdata blob, must be valid YAML. | `any` | no |

## Outputs

| Name | Description |
|------|-------------|
| primary_ip | The primary IP of the server. |
<!-- END_TF_DOCS -->

## Sample config

```hcl
module "cloudinit_template" {
  source = "github.com/glitchcrab/terraform-module-proxmox-cloudinit-template"

  conn_type         = "ssh"
  conn_user         = "root"
  conn_target       = "proxmox-host.domain.com"
  snippet_dir       = "/var/lib/vz"
  snippet_file_base = "my-instance"

  instance_name   = "my-instance"

  primary_network = {
    gateway = "172.16.0.1"
    ip      = "172.16.0.100"
    macaddr = "00:00:00:00:00:00"
    name    = "eth0"
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
