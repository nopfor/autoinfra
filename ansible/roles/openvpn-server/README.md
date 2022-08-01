
# OpenVPN Server

Create an OpenVPN server and generate client configurations.

To connect, point the OpenVPN to the generated client configuration:

```
sudo openvpn --config data/openvpn/SERVER_NAME_OR_IP-client.ovpn
```

## Client Configurations

VPN client configs are automatically generated for each client provided in the `vpn_clients` variable. These will be downloaded to `./data/openvpn/` by default and can be changed by setting the `local_output_dir` variable.

The clients come with commented-out options for specifying a DNS server and routing all over traffic over the VPN. Sites like [dnsleaktest.com](https://dnsleaktest.com/) can be used to test these settings.

## Variables

| Name               | Type      | Default           | Description
| ------------------ | --------- | ----------------- | -----------
| `vpn_clients`      | list(str) | ['client']        | Client configurations to be generated and downloaded
| `local_output_dir` | str       | DEFAULT           | Abolute path on local machine where client configs will be downloaded. Defaults to `{{ role_path }}/../../../data/openvpn` (`./data/openpvn/` from repo root), replacing DEFAULT.
| `vpn_port`         | int       | 443               | OpenVPN port
| `vpn_protocol`     | str       | tcp               | OpenVPN protocol (tcp or udp)
| `network_ip`       | str       | 10.8.0.0          | OpenVPN network IP
| `subnet_mask`      | str       | 255.255.255.0     | OpenVPN subnet mask
| `ca_cn`            | str       | VPN CA            | CA common name
| `server_cn`        | str       | DEFAULT           | Server common name, used for server certificate and the server in the client config. Defaults to IP or hostname Ansible connected with, replacing DEFAULT.
| `cert_country`     | str       | US                | Certificate country
| `cert_province`    | str       | NY                | Certificate province
| `cert_city`        | str       | New York          | Certificate city
| `cert_org`         | str       | autoinfra          | Certificate organization
| `cert_email`       | str       | admin@example.com | Certificate email
| `cert_ou`          | str       | VPN               | Certificate organizational unit
