#ADD file:9b5ba3935021955492697a04d541cc7797e4bea34365117fb9566c3117d01fdf in /

#RUN echo '#!/bin/sh' > /usr/sbin/policy-rc.d && echo 'exit 101' >> /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d && dpkg-divert --local --rename --add /sbin/initctl && cp -a /usr/sbin/policy-rc.d /sbin/initctl && sed -i 's/^exit.*/exit 0/' /sbin/initctl && echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup && echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean && echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean && echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean && echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages && echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes

#RUN sed -i 's/^#\s*\(deb.*universe\$/\1/g' /etc/apt/sources.list

#CMD "/bin/bash"

#MAINTAINER Randall Knutson <randall@form.io>

#RUN apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
#RUN apt-get update \
#    && RUN apt-get update \
#    && apt-get install -y \
#        build-essential \
#        autoconf \
#        nasm \
#        zlib1g-dev \
#        libpng-dev \
#        libkrb5-dev \
#        python \
#        git \
#        nodejs

#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#####

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
#RUN echo "[Unit]\n\
#Description=High-performance, schema-free document-oriented database]\n\
#Documentation=man:mongod(1)]\n\
#After=network.target]\n\
#\n\
#[Service]]\n\
#User=mongodb]\n\
#Group=mongodb]\n\
#ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf]\n\
#\n\
#[Install]]\n\
#WantedBy=multi-user.target" | tee /lib/systemd/system/mongodb.service

#RUN systemctl enable mongodb.service \
#    && systemctl start mongodb

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

# Expose listen port
EXPOSE 27017
EXPOSE 28017
EXPOSE 3001

# Expose our data volumes
# VOLUME ["/data"]