# Aws_Bucket_create
# AWS S3 Bucket Creation Script
#
This Bash script automates the creation of an AWS S3 bucket with best practices, including enabling versioning and blocking public access. It also checks for valid AWS CLI credentials before proceeding.

## Features

- Creates an S3 bucket in a specified region
- Enables versioning on the bucket
- Blocks all public access to the bucket
- Verifies AWS CLI credentials before any operation
- Provides clear error and usage messages

## Prerequisites

- [AWS CLI](https://aws.amazon.com/cli/) installed and configured (`aws configure`)
- Bash shell (Linux, macOS, or Windows with WSL/Git Bash)
- AWS credentials with permissions to create and manage S3 buckets

## Usage

```bash
./aws_s3_create.sh <bucket_name> <region>
```

**Example:**
```bash
./aws_s3_create.sh my-sample-bucket us-east-1
```

## Script Workflow

1. **Argument Check:** Ensures exactly two arguments are provided (bucket name and region).
2. **AWS CLI Check:** Verifies AWS CLI is installed and configured.
3. **Bucket Creation:** Creates the S3 bucket in the specified region.
4. **Enable Versioning:** Turns on versioning for the bucket.
5. **Block Public Access:** Applies a public access block configuration.
6. **Verification:** Lists the bucket to confirm creation and accessibility.

## Notes

- The script will exit with an error if any step fails.
- Make sure the bucket name is globally unique.
- Adjust permissions and policies as needed after creation.
