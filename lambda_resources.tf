locals {
  s3_deployment_code_bucket = var.certificate_manager_code_s3_bucket != "" ? (
    var.certificate_manager_code_s3_bucket
    ) : (
    "cyral-public-assets-${local.region}"
  )
  s3_deployment_code_key = var.certificate_manager_code_s3_key != "" ? (
    var.certificate_manager_code_s3_key
    ) : (
    "sidecar-certificate-manager/${var.certificate_manager_version}/sidecar-certificate-manager-lambda-${var.certificate_manager_version}.zip"
  )
}

resource "aws_lambda_function" "lambda-function" {
  function_name = "CyralSidecarCertificateManager-${random_id.current.id}"
  role          = aws_iam_role.lambda-execution-role.arn
  runtime       = "python3.8"
  handler       = "lambda_index.lambda_handler"
  timeout       = 300
  s3_bucket     = local.s3_deployment_code_bucket
  s3_key        = local.s3_deployment_code_key

  environment {
    variables = {
      CERTIFICATE_MANAGER_SIDECAR_DOMAIN              = var.sidecar_domain
      CERTIFICATE_MANAGER_SIDECAR_SUBDOMAIN           = var.sidecar_subdomains
      CERTIFICATE_MANAGER_REGISTRATION_EMAIL          = var.registration_email
      CERTIFICATE_MANAGER_SNOWFLAKE_ACCOUNT_REGION    = var.snowflake_account_region
      CERTIFICATE_MANAGER_SECRET_ID                   = aws_secretsmanager_secret.certificate-secret.id
      CERTIFICATE_MANAGER_RENEW_DAYS_BEFORE_EXPIRY    = var.renew_days_before_expiry
      CERTIFICATE_MANAGER_SIDECAR_SECRETS_MANAGE_ROLE = var.sidecar_secrets_manager_role_arn
    }
  }
}

# first-invocation emulates the lambda function being called from CloudFormation
# at time of stack creation.
resource "aws_lambda_invocation" "first-invocation" {
  function_name = aws_lambda_function.lambda-function.function_name
  input         = jsonencode({})
}

resource "aws_lambda_permission" "renewal-trigger-permission" {
  depends_on    = [aws_lambda_invocation.first-invocation]
  statement_id  = "renewal-trigger-permission"
  function_name = aws_lambda_function.lambda-function.function_name
  principal     = "events.amazonaws.com"
  action        = "lambda:InvokeFunction"
  source_arn    = aws_cloudwatch_event_rule.renewal-event.arn
}
