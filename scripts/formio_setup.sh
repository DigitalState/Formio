#!/bin/bash
FORMIO_MONGO_DSN=${FORMIO_MONGO_DSN:-mongodb://localhost:27017/xyz}
FORMIO_MONGO_SECRET=${FORMIO_MONGO_DSN:-changeme}
FORMIO_JWT_SECRET=${FORMIO_MONGO_DSN:-changeme}

cd /opt/formio/config
sed -i 's/FORMIO_MONGO_DSN/'"$FORMIO_MONGO_DSN"'/g' default.json
sed -i 's/FORMIO_MONGO_SECRET/'"$FORMIO_MONGO_SECRET"'/g' default.json
sed -i 's/FORMIO_JWT_SECRET/'"$FORMIO_JWT_SECRET"'/g' default.json

echo "========================================================================"
echo "Formio MongoDB DSN: \"$FORMIO_MONGO_DSN\""
echo "Formio MongoDB Secret: \"$FORMIO_MONGO_SECRET\""
echo "Formio JWT Secret: \"$FORMIO_JWT_SECRET\""
echo "========================================================================"

rm -f /.firstrun
