#!/bin/bash

chown kylo:users -R /opt/kylo/
chmod 600 /opt/kylo/users.properties
chmod 600 /opt/kylo/groups.properties

# Fix for missing log file
touch /velocity.log && chown kylo:users /velocity.log

/opt/kylo/bin/create-kylo-indexes-es.sh elasticsearch 9200 1 1

sed -E 's/(^java .*) > .+/\1/' /opt/kylo/kylo-services/bin/run-kylo-services.sh > /opt/kylo/kylo-services/bin/run-kylo-services-interactive.sh
chmod +x /opt/kylo/kylo-services/bin/run-kylo-services-interactive.sh
/opt/kylo/kylo-services/bin/run-kylo-services-interactive.sh
