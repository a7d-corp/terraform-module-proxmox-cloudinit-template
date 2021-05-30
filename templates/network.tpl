version: 2
ethernets:
  eth0:
    match:
      macaddress: '${primary_mac}'
    addresses:
      - ${primary_ip}
    gateway4: ${primary_ip_gateway}
    nameservers:
      search:
%{for domain in search_domains ~}
        - ${domain}
%{ endfor ~}
      addresses:
%{for ns in dns_servers ~}
        - ${ns}
%{ endfor ~}
  eth1:
    match:
      macaddress: '${secondary_mac}'
    addresses:
      - ${secondary_ip}
