#!/bin/bash

SCRIPT_DIR="$(dirname "$PWD/$0")"

echo "0 0 * * * root $SCRIPT_DIR/update.sh" > /etc/cron.d/cloudrevive
