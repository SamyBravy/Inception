FROM alpine:3.20

RUN	apk update && apk upgrade && apk add --no-cache nginx

RUN mkdir -p /etc/nginx/ssl && \
    apk add --no-cache openssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/sdell-er.42.fr.crt -keyout /etc/nginx/ssl/sdell-er.42.fr.key -subj "/C=IT/ST=Tuscany/L=Florence/O=42/OU=sdell-er/CN=sdell-er.42.fr"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
