FROM ghcr.io/linuxserver/baseimage-alpine:3.22

# install packages
RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	git \
	libressl \
	logrotate \
	nano \
	nginx \
	openssl \
	nodejs \
	npm \
	certbot \
	chromium \
	nss \
	freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    dumb-init && \
 echo "**** configure nginx ****" && \
 echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
	/etc/nginx/fastcgi_params && \
 rm -f /etc/nginx/conf.d/default.conf && \
 echo "**** fix logrotate ****" && \
 sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf && \
 sed -i 's#/usr/sbin/logrotate /etc/logrotate.conf#/usr/sbin/logrotate /etc/logrotate.conf -s /config/log/logrotate.status#g' \
	/etc/periodic/daily/logrotate
# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config

RUN \
 sed -i \
 	's|include /config/nginx/site-confs/\*;|include /config/nginx/site-confs/\*;\n\t#Removed lua. Do not remove this comment|g' \
	/defaults/nginx.conf && \
 npm install -g pm2