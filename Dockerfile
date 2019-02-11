FROM alpine:3.8
ARG gottyurl=https://github.com/yudai/gotty/archive/v2.0.0-alpha.3.tar.gz

RUN mkdir -p /gottysrc/src/github.com/yudai/gotty
RUN wget $gottyurl -O gotty.tar.gz
RUN tar -xvf gotty.tar.gz --strip-components=1 -C /gottysrc/src/github.com/yudai/gotty && rm -f gotty.tar.gz 
RUN apk add --no-cache musl-dev go
RUN cd gottysrc/src/github.com/yudai/gotty && GOPATH=/gottysrc go build -o gotty
RUN mv gottysrc/src/github.com/yudai/gotty/gotty /usr/bin/gotty
RUN chmod +x /usr/bin/gotty
RUN apk del go 
RUN rm -rf gottysrc && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV username=admin
ENV password=supersecretpassword
ENV gottyentry="/bin/ash"

ENTRYPOINT ["/entrypoint.sh"]



