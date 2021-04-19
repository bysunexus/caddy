FROM ghcr.io/hotio/base@sha256:6fa9179cf9aa06dd0d03645fb5920bf2fa7edf73e3505f34b59ecfcf7340a2c6

EXPOSE 8080 8443 2019

ENV CUSTOM_BUILD=""

RUN apk add --no-cache nss-tools fail2ban

ARG VERSION
RUN curl -fsSL "https://caddyserver.com/api/download?os=linux&arch=arm&arm=7&p=github.com%2Fmholt%2Fcaddy-webdav" -o "${APP_DIR}/caddy" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    ln -s "${APP_DIR}/caddy" "/usr/local/bin/caddy" && \
    cp -R /etc/fail2ban "${APP_DIR}/" && \
    rm -rf /etc/fail2ban && \
    ln -s "${CONFIG_DIR}/fail2ban" "/etc/fail2ban"

COPY root/ /
