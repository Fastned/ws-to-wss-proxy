# SPDX-License-Identifier: Apache-2.0
# © 2020 Fastned B.V.
FROM nginx:1.25.0-alpine-slim
MAINTAINER Fastned contact@fastned.nl

RUN apk update
RUN apk upgrade

COPY ./ws-to-wss-proxy.conf.template /etc/nginx/templates/default.conf.template

# Dnsmasq will be used as a fallback when the Docker embedded DNS server is not available.
RUN apk add dnsmasq-dnssec
COPY ./load-dnsmasq-if-necessary.sh /docker-entrypoint.d/99-load-dnsmasq-if-necessary.sh
RUN chmod +x /docker-entrypoint.d/99-load-dnsmasq-if-necessary.sh

RUN mkdir /cert
RUN chown nginx /cert
