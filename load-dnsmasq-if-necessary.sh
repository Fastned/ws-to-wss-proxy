#!/bin/sh
#
# Docker containers that run with the default `bridge` network don't have access to the Docker embedded DNS server.
# See https://docs.docker.com/config/containers/container-networking/#dns-services
# Since NGINX doesn't dynamically query /etc/resolv.conf and we don't want to use some public DNS server, we'll run
# dnsmasq as a fallback when the Docker embedded DNS server is not available.
#
if nslookup www.ams-ix.net 127.0.0.11 ; then
  echo "Docker's Embedded DNS server appears to be working. Dnsmasq not needed."
else
  echo "Embedded DNS server doesn't seem to be available. Loading dnsmasq as a fallback."
  dnsmasq
fi
