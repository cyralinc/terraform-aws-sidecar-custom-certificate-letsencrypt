locals {
  certificate_manager_code_real_s3_bucket = var.certificate_manager_s3_bucket != "" ? (
    var.certificate_manager_s3_bucket
    ) : (
    "cyral-public-assets-${local.region}"
  )
  certificate_manager_code_real_s3_key = var.certificate_manager_code_s3_key != "" ? (
    var.certificate_manager_code_s3_key
    ) : (
    "sidecar-custom-certificate/${var.certificate_manager_version}/sidecar-custom-certificate-lambda-${var.certificate_manager_version}.zip"
  )
  certificate_secret_id = local.should_use_different_account ? (
    var.sidecar_custom_certificate_secret_arn
    ) : (
    aws_secretsmanager_secret.certificate_secret[0].id
  )
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "CyralSidecarCustomCertificate-${random_id.current.id}"
  role          = aws_iam_role.lambda_execution_role.arn
  runtime       = "python3.9"
  handler       = "lambda_index.lambda_handler"
  timeout       = 300
  s3_bucket     = local.certificate_manager_code_real_s3_bucket
  s3_key        = local.certificate_manager_code_real_s3_key

  environment {
    variables = {
      CERTIFICATE_MANAGER_SECRET_ID                     = local.certificate_secret_id
      CERTIFICATE_MANAGER_SIDECAR_DOMAIN                = var.sidecar_domain
      CERTIFICATE_MANAGER_SIDECAR_SUBDOMAIN             = var.sidecar_subdomains
      CERTIFICATE_MANAGER_SNOWFLAKE_ACCOUNT_REGION      = var.snowflake_account_region
      CERTIFICATE_MANAGER_IS_STAGING_CERTIFICATE        = var.staging_certificate
      CERTIFICATE_MANAGER_REGISTRATION_EMAIL            = var.registration_email
      CERTIFICATE_MANAGER_RENEWAL_INTERVAL_WINDOW_START = var.renewal_interval_window_start
      CERTIFICATE_MANAGER_SIDECAR_SECRETS_MANAGER_ROLE  = var.sidecar_custom_certificate_role_arn
    }
  }
}

# first_invocation emulates the lambda function being called from
# CloudFormation at time of stack creation. The difference is that we do not
# specify `RequestType` in the event payload.
resource "aws_lambda_invocation" "first_invocation" {
  function_name = aws_lambda_function.lambda_function.function_name
  input         = jsonencode({})
}

resource "aws_lambda_permission" "renewal_trigger_permission" {
  depends_on    = [aws_lambda_invocation.first_invocation]
  statement_id  = "renewal_trigger_permission"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  action        = "lambda:InvokeFunction"
  source_arn    = aws_cloudwatch_event_rule.renewal_event.arn
}
