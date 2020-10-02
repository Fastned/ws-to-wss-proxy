#!/bin/sh
#
# Convenience script to generate a self-signed certificate that the proxy can use as a TLS client certificate when it
# connects to the https/wss server. When you're deploying the proxy in production, you probably don't want to rely on
# this script to generate the certificate.
#
# Once generated, the `clientcert.pem` will be the certificate that you need to submit to whomever manages any wss/https
# server(s) that you want the proxy server to connect to. The `clientcertkey.pem` file should not be shared, since
# that's the private key. Only the proxy server will need it.
#
# With thanks to https://stackoverflow.com/a/10176685
#
rm cert/*
openssl req -x509 -newkey rsa:4096 -keyout cert/clientcertkey.pem -out cert/clientcert.pem -days 365 -nodes -subj '/CN=localhost'
