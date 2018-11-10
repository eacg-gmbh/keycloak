#!/usr/bin/env bash

# Load the secrets from json description
rm -f /opt/jboss/tools/aws/secrets.sh
cat /opt/jboss/tools/aws/secrets.json | \
    jq -r "to_entries|map(\"\(.key),\(.value|.secret),\(.value|.item)\")|.[]" | \
    awk 'BEGIN {FS=","} {printf "export %s=\"$(aws secretsmanager get-secret-value --region eu-central-1 --secret-id \"%s\" | jq -r '\''.SecretString | fromjson.%s'\'')\"\n",$1,$2,$3}' | \
    while read -r line ; do echo $line >> /opt/jboss/tools/aws/secrets.sh ; done
