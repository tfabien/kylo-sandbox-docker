#!/bin/bash

chown kylo:users -R /opt/kylo/
chmod 600 /opt/kylo/users.properties
chmod 600 /opt/kylo/groups.properties

# Fix for missing log file
touch /velocity.log && chown kylo:users /velocity.log

/opt/kylo/bin/create-kylo-indexes-es.sh elasticsearch 9200 1 1

sed -i -E 's/(java.*)\s\> \/var\/log.*/\1/' /opt/kylo/kylo-services/bin/run-kylo-services.sh
/opt/kylo/kylo-services/bin/run-kylo-services.sh

#/etc/init.d/kylo-ui start
#/etc/init.d/kylo-services start
#tail -F /var/log/kylo-services/kylo-services.log -F /var/log/kylo-ui/kylo-ui.log