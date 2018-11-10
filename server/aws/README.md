## Parse secrets

```
export AWSUSER=$(aws secretsmanager get-secret-value --secret-id "trustsource/dev/aurora/idm" | jq -r '.SecretString | fromjson.username')
```

