#!/bin/bash
FORMIO_MONGO_DSN=${FORMIO_MONGO_DSN:-FORMIO_MONGO_DSN}
FORMIO_MONGO_SECRET=${FORMIO_MONGO_SECRET:-FORMIO_MONGO_SECRET}
FORMIO_JWT_SECRET=${FORMIO_JWT_SECRET:-FORMIO_JWT_SECRET}

cd /opt/formio/config

# Note: the use of `#` as a delimiter in the `sed` command below is because the env variable being substituted may contain slashes
#sed -i 's#FORMIO_MONGO_DSN#'"$FORMIO_MONGO_DSN"'#g' default.json
sed -i 's#"mongo": ".*"#"mongo": "'"$FORMIO_MONGO_DSN"'"#g' default.json

#sed -i 's/FORMIO_MONGO_SECRET/'"$FORMIO_MONGO_SECRET"'/g' default.json
sed -i 's/"mongoSecret": ".*"/"mongoSecret": "'"$FORMIO_MONGO_SECRET"'"/g' default.json

#sed -i 's/FORMIO_JWT_SECRET/'"$FORMIO_JWT_SECRET"'/g' default.json
sed -i 's/"secret": ".*"/"secret": "'"$FORMIO_JWT_SECRET"'"/g' default.json

echo "========================================================================"
echo "Formio MongoDB DSN: \"$FORMIO_MONGO_DSN\""
echo "Formio MongoDB Secret: \"$FORMIO_MONGO_SECRET\""
echo "Formio JWT Secret: \"$FORMIO_JWT_SECRET\""
echo "========================================================================"

rm -f /.firstrun
