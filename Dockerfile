FROM balenalib/raspberry-pi-alpine:3.9

LABEL maintainer="vmnet8 <vmnet8@gmail.com>" \
      description="NGINX on raspberry pi" \
      image.url="https://hub.docker.com/r/vmnet8/rpi-nginx/" \
      source="https://github.com/ole-vi/rpi-nginx"


ENV NGINX_VERSION 1.16

RUN apk --no-cache add nginx>${NGINX_VERSION} \
	&& mkdir -p /run/nginx \
	&& sed -i "s/ssl_session_cache shared:SSL:2m;/#ssl_session_cache shared:SSL:2m;/g" /etc/nginx/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
	
	
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

