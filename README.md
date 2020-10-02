# ws-to-wss-proxy

## What is this for?

The ws-to-wss-proxy can act as a bridge between OCPP clients that don't support TLS and OCPP servers that require TLS.
HTTP Basic Authentication can optionally be used. Note that TLS client certificates are not (yet) supported.

## Building the Dockerfile

The Dockerfile can be built in the regular way, by running the following command in the project root folder:

```bash
docker build -t ws-to-wss-proxy .
```

## Starting and accessing the proxy

To run the proxy in a Docker container, reachable on port 8080 on localhost, run the following Docker command: 

```bash
docker run -p 8080:80 -e NGINX_PORT=80 ws-to-wss-proxy
```

While the Docker container is running, you should be able to reach the OCPP server through the proxy without TLS.

The proxy determines the target WSS server dynamically from the URL at which any client accesses the proxy. You need to
take the WSS URL, without the `wss://` prefix, and then suffix it behind the `/wss` endpoint in the `ws://` URI.

For instance, if you started the Docker container through the example command above, and the TLS-requiring OCPP server
is reachable at `wss://my-csms.com/ocpp`, an OCPP client can now reach it through the proxy at
`ws://localhost:8080/wss/my-csms.com/ocpp`.
