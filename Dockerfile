FROM heroku/heroku:18

RUN mkdir -p /app/user
WORKDIR /app/user

# Install HAProxy

RUN apt-get update && apt-get install -y haproxy

# logging for HAProxy

#RUN apt-get install -y rsyslog  &&  \
#  mkdir -p /etc/rsyslog.d/      &&  \
#  touch /var/log/haproxy.log    &&  \
#  ln -sf /dev/stdout /var/log/haproxy.log

# Include our configurations (`./etc` contains the files that we'd
# need to have in the `/etc` of the container).
ADD ./etc/ /etc/

# Include our custom entrypoint that will the the job of lifting
# rsyslog alongside haproxy.
COPY ./entrypoint.sh /usr/local/bin/entrypoint

# Set our custom entrypoint as the image's default entrypoint
ENTRYPOINT [ "entrypoint" ]

# Make haproxy use the default configuration file
CMD [ "-f", "/etc/haproxy.cfg"]
