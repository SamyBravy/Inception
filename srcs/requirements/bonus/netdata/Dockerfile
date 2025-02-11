FROM debian:11

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y vim netdata procps

RUN sed -i 's/bind socket to IP = 127.0.0.1/bind socket to IP = 0.0.0.0/' /etc/netdata/netdata.conf

EXPOSE 19999

CMD ["/usr/sbin/netdata", "-D"]
