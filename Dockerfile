From alpine:latest

LABEL Maintainer="yiwei.duan@outlook.com" Description="This image is git." Version="1.0"

RUN set -xe \
	&& sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories \ 
    && apk add --no-cache --virtual .build-deps \ 
		tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone

RUN set -xe \
	&& apk add --no-cache --virtual .persistent-deps \
  		git \
  		openssh

RUN set -xe \
	&& mkdir ~/.ssh/ \
	&& touch ~/.ssh/id_rsa \
	&& chmod 600 ~/.ssh/id_rsa \
	&& apk del .build-deps \
    && rm -rf /var/cache/apt/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

VOLUME ["~/.ssh/id_rsa"]

WORKDIR /git

VOLUME ["/git"]