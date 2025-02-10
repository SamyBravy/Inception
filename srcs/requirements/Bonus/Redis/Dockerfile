FROM debian:11

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y redis-server

EXPOSE 6379

ENTRYPOINT ["redis-server", "--bind", "0.0.0.0", "--port", "6379", "--protected-mode", "no"]