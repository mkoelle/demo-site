#!/usr/bin/env bash
set +x #xtrace
set +v #verbose
set -e #errexit
set -u #nounset

region='us-east-1'
export AWS_DEFAULT_REGION=$region
export AWS_REGION=$region

s3_bucket_key='demo-site-content-bucket'

set -x

bucket=$(aws cloudformation list-exports --query "Exports[?Name=='${s3_bucket_key}'].Value" --output text)

aws s3 sync src s3://${bucket}
