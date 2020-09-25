# SPDX-License-Identifier: Apache-2.0
# © 2020 Fastned B.V.
FROM nginx:1.19.2-alpine
MAINTAINER Fastned contact@fastned.nl

COPY ./ws-to-wss-proxy.conf.template /etc/nginx/templates/default.conf.template
