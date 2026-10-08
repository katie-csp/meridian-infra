#!/usr/bin/env bash
# Creates the S3 bucket that holds OpenTofu remote state in LocalStack.
# Run once after LocalStack starts and before `tofu init`.
# Uses plain curl against LocalStack's S3 API, so the AWS CLI is not required.
set -euo pipefail

ENDPOINT="${LOCALSTACK_ENDPOINT:-http://localhost:4566}"
BUCKET="${STATE_BUCKET:-meridian-tofu-state}" # must match `bucket` in backend.tf

echo "Waiting for LocalStack at $ENDPOINT ..."
for _ in $(seq 1 30); do
  curl -sf "$ENDPOINT/_localstack/health" >/dev/null && break
  sleep 2
done
curl -sf "$ENDPOINT/_localstack/health" >/dev/null || { echo "LocalStack is not reachable"; exit 1; }

# HEAD returns 200 if the bucket exists, 404 if it does not
status=$(curl -s -o /dev/null -w "%{http_code}" -I "$ENDPOINT/$BUCKET")
if [ "$status" = "200" ]; then
  echo "State bucket '$BUCKET' already exists"
else
  curl -sf -X PUT "$ENDPOINT/$BUCKET" >/dev/null
  echo "Created state bucket '$BUCKET'"
fi

# Versioning keeps every previous state file, so a bad apply can be rolled back
curl -sf -X PUT "$ENDPOINT/$BUCKET?versioning" \
  -H 'Content-Type: application/xml' \
  -d '<VersioningConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Status>Enabled</Status></VersioningConfiguration>' >/dev/null
echo "Versioning enabled on '$BUCKET'"
