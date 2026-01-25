#!/bin/bash
set -e

# Variables
BUCKET_NAME="devops-aws-stack-tfstate-$(date +%s)"
AWS_REGION="eu-west-1"

echo "Setting up Terraform remote backend..."

# 1. Create S3 bucket for Terraform state
echo "Creating S3 bucket: ${BUCKET_NAME}"
aws s3 mb "s3://${BUCKET_NAME}" --region ${AWS_REGION}

# 2. Enable versioning
echo "Enabling versioning..."
aws s3api put-bucket-versioning \
  --bucket ${BUCKET_NAME} \
  --versioning-configuration Status=Enabled

# 3. Enable encryption
echo "Enabling encryption..."
aws s3api put-bucket-encryption \
  --bucket ${BUCKET_NAME} \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'

# 4. Block public access
echo "Blocking public access..."
aws s3api put-public-access-block \
  --bucket ${BUCKET_NAME} \
  --public-access-block-configuration \
    "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

# 5. Configure lifecycle
echo "Configuring bucket lifecycle..."
aws s3api put-bucket-lifecycle-configuration \
  --bucket ${BUCKET_NAME} \
  --lifecycle-configuration '{
    "Rules": [{
      "ID": "DeleteOldVersions",
      "Filter": {},
      "Status": "Enabled",
      "NoncurrentVersionExpiration": {
        "NoncurrentDays": 90
      }
    }]
  }'

echo "Backend setup complete: ${BUCKET_NAME}"
