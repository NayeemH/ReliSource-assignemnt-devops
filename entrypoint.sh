#!/bin/bash
set -e

# Required environment variables
AZP_URL=${AZP_URL}
AZP_TOKEN=${AZP_TOKEN}
AZP_POOL=${AZP_POOL}
AZP_AGENT_NAME=${AZP_AGENT_NAME}

if [[ -z "$AZP_URL" || -z "$AZP_TOKEN" ]]; then
    echo "Error: AZP_URL and AZP_TOKEN must be set"
    exit 1
fi

# Configure Azure DevOps agent
echo "Configuring Azure DevOps agent..."
./config.sh --unattended --url "$AZP_URL" --auth pat --token "$AZP_TOKEN" --pool "$AZP_POOL" --agent "$AZP_AGENT_NAME" --replace

# Run agent
echo "Running Azure DevOps agent..."
exec ./run.sh
