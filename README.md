# ws-to-wss-proxy

## What is this for?

The ws-to-wss-proxy can act as a bridge between WebSocket clients that don't support TLS and WebSocket servers that
require TLS. HTTP Basic Authentication can optionally be used. TLS client certificates are also supported.

## Building the Dockerfile

The Dockerfile can be built in the regular way, by running the following command in the project root folder:

```bash
docker build -t ws-to-wss-proxy .
```

## Generating a TLS client certificate

Although most wss/https servers don't require a TLS client certificate, the NGINX configuration template is currently
hard-coded to assume the existence of a TLS client certificate in the mounted directory `/cert`, and will therefore
require one.

If the `cert` folder doesn't yet contain a certificate (`clientcert.pem`) and its corresponding private key
(`clientcertkey.pem`), you can run the provided convenience script to create these, since the Docker container will look
for the certificate and the key and will fail to start if it doesn't find them. Run the convenience script as follows:

```bash
./generate-client-cert.sh
```

## Starting and accessing the proxy

To run the proxy in a Docker container, reachable on port 8080 on localhost, with the TLS client certificate you
generated as instructed above, run the following Docker command:

```bash
docker run -p 8080:80 -e NGINX_PORT=80 -v $(pwd)/cert:/cert ws-to-wss-proxy
```

While the Docker container is running, you should be able to reach the WebSocket server through the proxy without TLS.

The proxy determines the target WSS server dynamically from the URL at which any client accesses the proxy. You need to
take the WSS URL, without the `wss://` prefix, and then suffix it behind the `/wss` endpoint in the `ws://` URI.

For instance, if you started the Docker container through the example command above, and the TLS-requiring WebSocket
server is reachable at `wss://my-csms.com/ocpp`, a WebSocket client should now be able to reach it through the proxy at
`ws://localhost:8080/wss/my-csms.com/ocpp`, provided that the WebSocket client is running in the same environment in
which the Docker container is deployed.

You may have to set up some routing and use something other than `localhost` for the WebSocket client to reach the proxy
if they are running on different machines, but that shouldn't be too hard to figure out.

Note that if the wss/https server requires a TLS client certificate, you need to provide whomever maintains that
server with a copy of the file `cert/clientcert.pem` (**not** `clientcertkey.pem`!), and ask them to configure it as
the TLS client certificate that will identify the client that you will be trying to connect to that server through the
proxy. If you don't take care of this beforehand, the connection will likely be rejected by the server, probably with an
HTTP 401 response.
