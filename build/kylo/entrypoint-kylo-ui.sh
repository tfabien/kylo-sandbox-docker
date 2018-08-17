#!/bin/bash

sed -E 's/(^java .*) > .+/\1/' /opt/kylo/kylo-ui/bin/run-kylo-ui.sh > /opt/kylo/kylo-ui/bin/run-kylo-ui-interactive.sh
chmod +x /opt/kylo/kylo-ui/bin/run-kylo-ui-interactive.sh
/opt/kylo/kylo-ui/bin/run-kylo-ui-interactive.sh