FROM mhart/alpine-node:6.10.3

RUN apk add --no-cache make gcc g++ python

RUN mkdir -p /opt

COPY formio /opt/formio

RUN cd /opt/formio && npm rebuild

COPY scripts /scripts

RUN chmod +x /scripts/*.sh

ENTRYPOINT /scripts/run.sh

CMD ['']
