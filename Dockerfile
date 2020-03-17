FROM alpine:latest as builder

LABEL build_version="0.0.1"
LABEL maintainer="kakotor"

RUN apk add --no-cache openssh-client ca-certificates git wget

RUN wget "https://caddyserver.com/download/linux/amd64?plugins=http.realip,http.cors,http.minify,tls.dns.cloudflare,http.webdav&license=personal&telemetry=off" -O tmp.tar.gz && tar xzf tmp.tar.gz && rm tmp.tar.gz


FROM alpine:latest

WORKDIR /caddy

COPY Caddyfile /caddy/Caddyfile
COPY --from=builder caddy /usr/bin/caddy

RUN mkdir /srv/dav/ && /usr/bin/caddy -version && /usr/bin/caddy -plugins

ENTRYPOINT ["caddy"]
CMD ["--conf", "/caddy/Caddyfile", "--log", "stdout"]
VOLUME /caddy /davroot
ENV CLOUDFLARE_EMAIL="" 
ENV CLOUDFLARE_API_KEY=""
EXPOSE 1443