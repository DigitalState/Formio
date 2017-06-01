FROM ubuntu:16.04

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential checkinstall

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libreadline-gplv2-dev \
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    tcl8.5 \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    systemd \
    apt-utils \
    curl \
    wget

# Python 2.7
RUN cd ~ \
    && wget http://python.org/ftp/python/2.7.12/Python-2.7.12.tgz \
    && tar -xvf Python-2.7.12.tgz \
    && cd Python-2.7.12 \
    && ./configure \
    && make \
    && checkinstall -y \
    && cd ~ \
    && rm -rf Python* \

# Node.js
RUN cd ~ \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash -\
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

## PM2
RUN [ -d /root ] || mkdir /root
RUN npm install -g pm2

## Formio
ADD formio /opt/formio
#RUN cd /opt/formio && npm install
RUN cd /opt/formio && npm rebuild

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun

# Command to run
ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

# Expose ports
# EXPOSE 3001

# Expose our data volumes
# VOLUME ["/data"]