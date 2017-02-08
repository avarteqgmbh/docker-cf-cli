FROM alpine:latest

MAINTAINER Robert Gogolok <gogolok@gmail.com>

# Install dependencies
ENV GOPATH=/usr/local/bin

# Install CF CLI and plugins
RUN apk add --update curl && \
    curl -L 'https://github.com/geofffranks/spruce/releases/download/v1.8.9/spruce-linux-amd64' --output /usr/local/bin/spruce && chmod +x /usr/local/bin/spruce && \
    curl -L 'https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.23.1' | tar -zx -C /usr/local/bin
RUN apk add --update --quiet --no-cache --virtual build-dependencies build-base git go && \
    git config --global http.https://gopkg.in.followRedirects true && \
    go get github.com/bluemixgaragelondon/cf-blue-green-deploy && \
    cf install-plugin $GOPATH/bin/cf-blue-green-deploy -f  && \
    apk del build-dependencies && rm -rf /var/cache/apk/* && rm -rf $GOPATH
