FROM debian:11

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

RUN npm install -g serve

COPY requirements/bonus/static/site /app

WORKDIR /app

EXPOSE 3000

CMD ["serve", "-s", ".", "-l", "3000"]
