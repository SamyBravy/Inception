FROM debian:11

RUN apt-get update -y && apt-get install -y vsftpd

COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY tools/setup.sh /setup.sh

RUN mkdir -p /var/log/ftp && \
	chown -R ftp:ftp /var/log/ftp

RUN chmod +x /setup.sh

EXPOSE 21 30000-30009

CMD ["bash", "/setup.sh"]
