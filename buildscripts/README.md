## Update Sidecar Certificate Manager Lambda code

To update the certificate manager used by the terraform deployment, just run

```shell
./buildscripts/update_lambda_package.sh
```

from the project's root directory. That will update the S3 object key reference
in the file `lambda_locals.tf` to the latest stable version available.
