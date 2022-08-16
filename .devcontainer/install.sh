#!/bin/bash
set -e

set -a
. ./devcontainer-features.env
set +a

if [ ! -z ${_BUILD_ARG_AZUREBICEP} ]; then
    echo "Activating feature 'Azure Bicep'"

    # Azure Bicep CLI version 
    CLIVERSION=${_BUILD_ARG_AZUREBICEP_VERSION:-"latest"}

    if [ "${CLIVERSION}" = "latest" ]; then        
        CLIURL="https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64"
    else
        CLIURL="https://github.com/Azure/bicep/releases/download/${CLIVERSION}/bicep-linux-x64"
    fi

    sudo tee /usr/installbicep.sh > /dev/null \
    << EOF
    sudo curl -Lo /usr/local/bin/bicep ${CLIURL}
    sudo chmod +x /usr/local/bin/bicep
EOF
    sudo chmod +x /usr/installbicep.sh
fi