
# Squid Proxy

Create a squid proxy on a non-standard port.

Access denied by default, networks need to be added using the `allow_networks` variable.

## Variables

| Name             | Type      | Default  | Description
| ---------------- | --------- | -------- | -----------
| `allow_networks` | list(str) | \[\]     | List of source networks to allow
| `deny_networks`  | list(str) | \[\]     | List of source networks to explicitly deny
| `proxy_user`     | str       | autoinfra | Squid proxy user (required for authentication)
| `proxy_pass`     | str       | autoinfra | Squid proxy password (required for authentication)
| `proxy_port`     | int       | 8312     | Squid proxy port
