FROM formio/ubuntu-base:latest

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
    && curl -sL https://deb.nodesource.com/setup_4.x \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

## MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated mongodb-org

RUN mkdir /data

## PM2
RUN mkdir /root
RUN npm install -g pm2

## Formio
#ADD formio-master /opt/formio
#RUN cd /opt/formio && npm install

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun

# Command to run
ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

# Expose ports
# EXPOSE 27017
# EXPOSE 28017
EXPOSE 3001

# Expose our data volumes
# VOLUME ["/data"]