FROM debian:11

RUN apt-get update -y && apt-get install -y vsftpd

COPY conf/vsftpd.conf /etc/vsftpd.conf

RUN useradd -m -d /var/www/wordpress -s /bin/bash ftpuser && \
    echo "ftpuser:ftppassword" | chpasswd

EXPOSE 21 30000-30009

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
