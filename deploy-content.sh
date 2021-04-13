#!/usr/bin/env bash
set +x #xtrace
set +v #verbose
set -e #errexit
set -u #nounset

region='us-east-1'
export AWS_DEFAULT_REGION=$region
export AWS_REGION=$region

projectkey='demo-site-content'

set -x

bucket=$(aws cloudformation list-exports --query "Exports[?Name=='${projectkey}-bucket'].Value" --output text)
URL=$(aws cloudformation list-exports --query "Exports[?Name=='${projectkey}-domain'].Value" --output text)

aws s3 sync src s3://${bucket}
echo "check it out at $URL"