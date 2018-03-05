#!/bin/sh

# Install tools required for pre-run steps
cd /srv/formio/tools
npm run update-config-from-env

# Start the Formio server
cd /srv/formio
npm start
