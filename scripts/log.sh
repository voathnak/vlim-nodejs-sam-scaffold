#!/usr/bin/env bash

if [ $# -gt 0 ]; then
    echo "Showing log for resource name: $1 ..."
else
    echo "No resource name provided."
fi

source scripts/config.sh
sam logs --profile "$PROFILE" -n $1 --stack-name "$STACK_NAME" --region "$REGION" --tail
