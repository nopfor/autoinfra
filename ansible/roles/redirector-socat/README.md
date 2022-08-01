
# Socat Redirector

TCP redirector using `socat`. Runs on the host in a screen session.

## Variables

| Name          | Type | Default    | Description
| ------------- | ---- | ---------- | -----------
| `listen_port` | int  | 443        | Listen port
| `remote_host` | str  | 127.0.0.1  | Remote host
| `remote_port` | int  | 443        | Remote port
| `protocol`    | str  | tcp        | Protocol for redirection. tcp or udp.
