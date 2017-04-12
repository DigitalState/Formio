#!/bin/bash

# Initialize first run
if [[ -e /.firstrun ]]; then
    /scripts/mongo_setup.sh
fi

# Start MongoDB
echo "Starting MongoDB..."
/usr/bin/mongod --dbpath /data --noauth --logpath /var/log/mongodb/general.log $@
#tail -f /dev/null