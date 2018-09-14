#!/bin/bash

chown kylo:users -R /opt/kylo/
chmod 600 /opt/kylo/users.properties
chmod 600 /opt/kylo/groups.properties

# Fix for missing log file
touch /velocity.log && chown kylo:users /velocity.log

# Launch Kylo Services
/opt/kylo/kylo-services/bin/run-kylo-services-interactive.sh
