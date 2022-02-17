resource "aws_lambda_function" "lambda_function" {
  function_name = var.deployment_id
  role          = aws_iam_role.lambda_execution_role.arn
  runtime       = "python3.8"
  handler       = "lambda_index.lambda_handler"
  timeout       = 300
  s3_bucket     = local.s3_deployment_code_bucket
  s3_key        = local.s3_deployment_code_key

  environment {
    variables = {
      CERTIFICATE_MANAGER_SIDECAR_DOMAIN           = var.sidecar_domain
      CERTIFICATE_MANAGER_SIDECAR_SUBDOMAIN        = var.sidecar_subdomains
      CERTIFICATE_MANAGER_REGISTRATION_EMAIL       = var.registration_email
      CERTIFICATE_MANAGER_SNOWFLAKE_ACCOUNT_REGION = var.snowflake_account_region
      CERTIFICATE_MANAGER_SECRET_NAME = var.certificate_secret_suffix == "" ? (
        "/cyral/sidecars/certificate/${var.deployment_id}"
        ) : (
        "/cyral/sidecars/certificate/${var.certificate_secret_suffix}"
      )
      CERTIFICATE_MANAGER_RENEW_DAYS_BEFORE_EXPIRY    = var.renew_days_before_expiry
      CERTIFICATE_MANAGER_SIDECAR_SECRETS_MANAGE_ROLE = var.sidecar_secrets_manager_role_arn
    }
  }
}

# first_invocation emulates the lambda function being called from CloudFormation
# at time of stack creation.
resource "aws_lambda_invocation" "first_invocation" {
  function_name = aws_lambda_function.lambda_function.function_name
  input         = jsonencode({})
}

resource "aws_lambda_permission" "renewal_trigger_permission" {
  depends_on    = [aws_lambda_invocation.first_invocation]
  statement_id  = "renewal_trigger_permission"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.renewal_event.arn
}
