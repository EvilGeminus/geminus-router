FROM heroku/heroku:18

RUN mkdir -p /app/user
WORKDIR /app/user

# Install HAProxy

RUN apt-get update && apt-get install -y haproxy

COPY haproxy.cfg /app/user/haproxy.cfg
