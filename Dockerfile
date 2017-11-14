FROM mhart/alpine-node:6.10.3

RUN apk add --no-cache make gcc g++ python

RUN mkdir -p /opt

COPY formio /opt/formio

RUN cd /opt/formio && npm rebuild

RUN chmod +x /opt/formio/docker/*.sh

ENTRYPOINT /opt/formio/docker/run.sh

CMD ['']
