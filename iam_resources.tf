data "aws_iam_policy_document" "lambda_execution" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_execution_policy" {
  # Cloudwatch permissions
  statement {
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "arn:${local.partition}:logs:${local.region}:${local.account_id}:*"
    ]
  }
  statement {
    actions   = ["cloudwatch:PutMetricData"]
    resources = ["*"]
  }

  # Route53 permissions
  statement {
    actions = [
      "route53:GetChange",
      "route53:ChangeResourceRecordSets"
    ]
    resources = [
      "arn:${local.partition}:route53:::change/*",
      "arn:${local.partition}:route53:::hostedzone/*"
    ]
  }
  statement {
    actions   = ["route53:ListHostedZones"]
    resources = ["*"]
  }

  # Secrets Manager permissions
  statement {
    actions = local.should_use_different_account ? ([
      "sts:AssumeRole"
      ]) : ([
      "secretsmanager:GetSecretValue",
      "secretsmanager:UpdateSecret"
    ])
    resources = local.should_use_different_account ? ([
      var.sidecar_custom_certificate_role_arn
      ]) : ([
      "arn:${local.partition}:secretsmanager:${local.region}:${local.account_id}:secret:/cyral/sidecars/certificate/*"
    ])
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name               = "CyralSidecarCustomCertificateLambdaExecutionRole-${random_id.current.id}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_execution.json
}

resource "aws_iam_policy" "lambda_execution_policy" {
  name   = "CyralSidecarCustomCertificateLambdaExecutionPolicy-${random_id.current.id}"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_execution_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}
