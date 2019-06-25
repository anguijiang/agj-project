FROM node:12.4-alpine

LABEL author="响当当"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add git
ENV UID=1000

WORKDIR /wwwroot

USER node:node