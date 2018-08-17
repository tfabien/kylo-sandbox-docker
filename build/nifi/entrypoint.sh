#!/bin/bash

/etc/init.d/nifi start
tail -F /var/log/nifi/nifi-bootstrap.log /var/log/nifi/nifi-app.log /var/log/nifi/nifi-user.log 