## Update Sidecar Certificate Manager Lambda code

To update the certificate manager used by the terraform deployment, just run
the following command from the project's root directory. You must have a bash
shell installed. That will update the S3 object key reference in the file
`lambda_locals.tf` to the latest stable version available.

```shell
./buildscripts/update_lambda_package.sh <aws-region>
```

where: `<aws-region>` is one of the AWS regions that has a bucket with the
certificate manager Lambda code package. At the time of writing, this includes
`us-east-1`, `us-east-2`, `us-west-1`, `us-west-2`.
