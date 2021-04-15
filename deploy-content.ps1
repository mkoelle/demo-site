
$region='us-east-1'
$env:AWS_DEFAULT_REGION=$region
$env:AWS_REGION=$region

$s3_bucket_key='demo-site-content-bucket'

$bucket=(aws cloudformation list-exports --query "Exports[?Name=='${s3_bucket_key}'].Value" --output text)

npm ci
npm run build

aws s3 sync dist s3://${bucket}
