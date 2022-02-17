#!/bin/bash

set -xe

# Set the capitalized env variables before running the script!
region=${REGION}
bucket="cyral-public-assets-${region}" # Default value
if [ "${BUCKET}" != "" ]; then
  bucket="${BUCKET}"
fi

# General variables
latest_cft_key='sidecar-certificate-manager/sidecar-certificate-manager-cft-latest.yaml'
temp_cft_path='update_lambda_package_temp_cft.yaml'

# Fetch CFT from S3 to find the latest zip deployment package
aws s3api get-object \
  --bucket "${bucket}" \
  --key "${latest_cft_key}" \
  "${temp_cft_path}"

# Substitute current object key with latest
target_file=lambda_locals.tf
latest_zip_key=$(perl -f buildscripts/pick_s3_object_key.pl "${temp_cft_path}")
cat "${target_file}" |
  tr '\n' '@' |
  perl -0f buildscripts/inject_key.pl "${latest_zip_key}" |
  tr '@' '\n' 1> \
  "temp-${target_file}"
mv "temp-${target_file}" "${target_file}"

# Clean temp files
rm "${temp_cft_path}"
