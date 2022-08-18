version: 2
ethernets:
  ${primary_network.name}:
    match:
      macaddress: '${primary_network.macaddr}'
    addresses:
      - ${primary_network.ip}/${primary_network.netmask}
    gateway4: ${primary_network.gateway}
    nameservers:
      search:
%{for domain in search_domains ~}
        - ${domain}
%{ endfor ~}
      addresses:
%{for ns in dns_servers ~}
        - ${ns}
%{ endfor ~}
%{ for network in extra_networks ~}
  ${network.name}:
    match:
      macaddress: '${network.macaddr}'
    addresses:
%{ for ip in network.ips ~}
      - ${ip}/${network.netmask}
%{ endfor ~}
%{ endfor ~}
