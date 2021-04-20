FROM ghcr.io/hotio/base@sha256:047c65b9a204d6936c5aaa69e085cad72bc15bd9df9c582de7fd94c2470a7daa

EXPOSE 8080 8443 2019

ENV CUSTOM_BUILD=""

RUN apk add --no-cache nss-tools fail2ban

ARG VERSION
RUN curl -fsSL "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Fmholt%2Fcaddy-webdav" -o "${APP_DIR}/caddy" && \
    chmod -R 777 "${APP_DIR}" && \
    ln -s "${APP_DIR}/caddy" "/usr/local/bin/caddy" && \
    cp -R /etc/fail2ban "${APP_DIR}/" && \
    rm -rf /etc/fail2ban && \
    ln -s "${CONFIG_DIR}/fail2ban" "/etc/fail2ban"

COPY root/ /
