FROM balenalib/raspberry-pi-alpine:3.9

LABEL org.opencontainers.image.authors="Tobias Hargesheimer <docker@ison.ws>" \
	org.opencontainers.image.title="NGINX" \
	org.opencontainers.image.description="AlpineLinux with NGINX on arm arch" \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.url="https://hub.docker.com/r/tobi312/rpi-nginx/" \
	org.opencontainers.image.source="https://github.com/Tob1asDocker/rpi-nginx"


ENV NGINX_VERSION 1.14

RUN apk --no-cache add nginx>${NGINX_VERSION} \
	&& mkdir -p /run/nginx \
	&& sed -i "s/ssl_session_cache shared:SSL:2m;/#ssl_session_cache shared:SSL:2m;/g" /etc/nginx/nginx.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
	
	
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

