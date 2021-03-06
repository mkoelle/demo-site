#!/usr/bin/env bash
set +x #xtrace
set +v #verbose
set -e #errexit
set -u #nounset

region='us-east-1'
export AWS_DEFAULT_REGION=$region
export AWS_REGION=$region

projectkey='demo-site'

set -x

bucket=$(aws cloudformation list-exports --query "Exports[?Name=='${projectkey}-content-bucket'].Value" --output text)
URL=$(aws cloudformation list-exports --query "Exports[?Name=='${projectkey}-domain'].Value" --output text)

npm ci
npm run build

aws s3 sync dist s3://${bucket}
echo "check it out at $URL"