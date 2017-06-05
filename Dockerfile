FROM mhart/alpine-node:6.10.3

RUN apk add --no-cache make gcc g++ python

## PM2
#RUN [ -d /root ] || mkdir /root
#RUN npm install -g pm2

## Formio
RUN mkdir -p /opt
ADD formio /opt/formio
RUN cd /opt/formio && npm rebuild

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
#RUN touch /.firstrun

# Command to run
ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

# Expose ports
# EXPOSE 3001

# Expose our data volumes
# VOLUME ["/data"]