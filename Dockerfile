FROM alpine:3.5

ENV PACKAGES "curl"
RUN apk add --update $PACKAGES && rm -rf /var/cache/apk/*

RUN curl -L 'https://github.com/geofffranks/spruce/releases/download/v1.8.9/spruce-linux-amd64' --output /usr/local/bin/spruce
RUN chmod +x /usr/local/bin/spruce

RUN curl -L 'https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.23.1' | tar -zx -C /usr/local/bin
