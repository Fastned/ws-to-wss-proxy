# ws-to-wss-proxy

## What is this for?

The ws-to-wss-proxy can act as a bridge between OCPP clients that don't support TLS and OCPP servers that require TLS.
HTTP Basic Authentication can optionally be used. Note that TLS client certificates are not (yet) supported.

## Building the Dockerfile

The Dockerfile can be built in the regular way:

```bash
docker build -t ws-to-wss-proxy
```

## Starting and accessing the proxy

To run the proxy in a Docker container, reachable on port 8080 on localhost, run the following Docker command: 

```bash
# Assuming that the OCPP server is reachable at wss://my-csms.com/ocpp
docker run -p 8080:80 -e NGINX_PORT=80 -e WSS_SERVER_URL=my-csms.com ws-to-wss-proxy
```

While the Docker container is running, you should be able to reach the OCPP server through the proxy without TLS at
`ws://localhost:8080/ocpp`.
