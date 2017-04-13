#!/bin/bash

# Initialize first run
if [[ -e /.firstrun ]]; then
    /scripts/mongo_setup.sh
    /scripts/formio_setup.sh
fi

# Start MongoDB
echo "Starting MongoDB..."
/usr/bin/mongod --dbpath /data --noauth --logpath /var/log/mongodb/general.log $@ &

# Start the Formio app
cd /opt/formio
node main

#tail -f /dev/null