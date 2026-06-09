#!/bin/bash -eu

# Require the COMPONENT_INFO variable
if [[ -z "${COMPONENT_INFO-}" ]]; then
    >&2 echo "Empty COMPONENT_INFO variable"
    exit 1
fi

# Set a default GITHUB_OUTPUT if we are not in a GitHub actions runner
if [[ "${GITHUB_ACTIONS-}" != "true" ]]; then
    echo "Running outside a GitHub action"
    export GITHUB_OUTPUT="/dev/null"
fi

# Parse the .deployments.environments field, and expose it through the ALL_ENVIRONMENTS output
echo "Listing all environments from .deployments.environments"
ALL_ENVIRONMENTS=$(echo "$COMPONENT_INFO" | jq -rc '.deployments.environments | keys')
echo "ALL_ENVIRONMENTS=$ALL_ENVIRONMENTS" | tee -a "$GITHUB_OUTPUT"

# Gather all step environment names in order
echo "Determining next deployment step, from .deployments.sequence"
ENVIRONMENTS_SEQUENCE=$(echo "$COMPONENT_INFO" | jq -rc '.deployments.sequence | map(.environment)')

# Check the number of steps specified
SEQUENCE_LENGTH=$(echo "$ENVIRONMENTS_SEQUENCE" | jq -rc 'length')
if [[ "$SEQUENCE_LENGTH" == "0" ]]; then
    # If there are no steps, exit early, setting DONE=true
    echo "Deployment sequence is empty"
    echo "DONE=true" | tee -a "$GITHUB_OUTPUT"
    exit 0
fi

# Determine the next step, and if we are done or not
if [[ -z "${PREVIOUS_ENVIRONMENT-}" ]]; then
    echo "No previous environment detected, identifying first step in the sequence"
    FIRST_STEP=$(echo "$ENVIRONMENTS_SEQUENCE" | jq -rc '.[0]')
    echo "NEXT_ENVIRONMENT=$FIRST_STEP" | tee -a "$GITHUB_OUTPUT"
    echo "DONE=false" | tee -a "$GITHUB_OUTPUT"
else
    echo "Previous environment was '$PREVIOUS_ENVIRONMENT', searching for a next step in the sequence"
    PREVIOUS_STEP_FOUND=false
    NEXT_STEP_FOUND=false
    STEPS_AS_LINES=$(echo "$ENVIRONMENTS_SEQUENCE" | jq -rc '.[]')
    while IFS= read -r STEP || [[ -n "$STEP" ]]; do
        if [[ "$PREVIOUS_STEP_FOUND" == "true" ]]; then
            # If we just found the previous step in the last iteration, this iteration is the next step
            NEXT_STEP_FOUND=true
            echo "NEXT_ENVIRONMENT=$STEP" | tee -a "$GITHUB_OUTPUT"
            echo "DONE=false" | tee -a "$GITHUB_OUTPUT"
            break
        elif [[ "$STEP" == "$PREVIOUS_ENVIRONMENT" ]]; then
            # If we have found the previous step, mark a flag so we can exit in the next iteration
            PREVIOUS_STEP_FOUND=true
        fi
    done <<< "$STEPS_AS_LINES"

    if [[ "$NEXT_STEP_FOUND" != "true" ]]; then
        # If we did not find any next step, we are done
        echo "DONE=true" | tee -a "$GITHUB_OUTPUT"
    fi
fi
