#!/bin/bash
# Create an S3 bucket with a specific name and region
# and check credentials of aws cli before eecuting the command
# Usage: ./aws_s3_create.sh <bucket_name> <region>

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 sample-bucket us-central-1"
    exit 1
fi
BUCKET_NAME=$1
REGION=$2
# Check if AWS CLI is configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "AWS CLI is not configured. Please configure it using 'aws configure'."
    exit 1
fi      
# Create the S3 bucket
if aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" --create-bucket-configuration LocationConstraint="$REGION"; then
    echo "Bucket '$BUCKET_NAME' created successfully in region '$REGION'."
else
    echo "Failed to create bucket '$BUCKET_NAME'. Please check the bucket name and region."
    exit 1
fi  
# Enable versioning on the bucket
if aws s3api put-bucket-versioning --bucket "$BUCKET_NAME" --versioning-configuration Status=Enabled; then
    echo "Versioning enabled on bucket '$BUCKET_NAME'."
else
    echo "Failed to enable versioning on bucket '$BUCKET_NAME'."
    exit 1
fi
# Enable public access block on the bucket
if aws s3api put-public-access-block --bucket "$BUCKET_NAME" --public-access-block-configuration '{
    "BlockPublicAcls": true,
    "IgnorePublicAcls": true,
    "BlockPublicPolicy": true,
    "RestrictPublicBuckets": true
}'; then
    echo "Public access block enabled on bucket '$BUCKET_NAME'."        
else
    echo "Failed to enable public access block on bucket '$BUCKET_NAME'."
    exit 1
fi
# Output the bucket details
echo "Bucket '$BUCKET_NAME' created successfully with versioning enabled and public access block configured."
echo "You can access the bucket at: s3://$BUCKET_NAME/" 
echo "Remember to configure your bucket policies and permissions as needed."
# List the bucket to verify creation
if aws s3 ls "s3://$BUCKET_NAME" &> /dev/null; then
    echo "Bucket '$BUCKET_NAME' is accessible."
else    
    echo "Bucket '$BUCKET_NAME' is not accessible. Please check your permissions."
    exit 1
fi  
