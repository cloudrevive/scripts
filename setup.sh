#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "0 0 * * * root $SCRIPT_DIR/update.sh" > /etc/cron.d/cloudrevive
