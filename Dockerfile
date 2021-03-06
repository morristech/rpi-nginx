FROM balenalib/raspberry-pi-alpine:3.9

LABEL org.opencontainers.image.maintainer="vmnet8 <vmnet8@ole.org>" \
      org.opencontainers.image.title="NGINX" \
      org.opencontainers.image.description="NGINX on raspberry pi" \
      org.opencontainers.image.licenses="AGPL v3.0" \
      org.opencontainers.image.description="NGINX on raspberry pi" \
      org.opencontainers.image.url="https://hub.docker.com/r/treehouses/rpi-nginx/" \
      org.opencontainers.image.source="https://github.com/treehouses/rpi-nginx"


ENV NGINX_VERSION 1.16

RUN apk --no-cache add nginx>${NGINX_VERSION} \
	&& mkdir -p /run/nginx \
	&& sed -i "s/ssl_session_cache shared:SSL:2m;/#ssl_session_cache shared:SSL:2m;/g" /etc/nginx/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
		
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

