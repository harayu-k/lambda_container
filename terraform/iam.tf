resource "aws_iam_role" "lambda_exec" {
  name = "lambda"
  path = "/system/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy.json
}

data "aws_iam_policy_document" "lambda_assume_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "lambda_execute_role_managed_policy" {
  role_name = aws_iam_role.lambda_exec.name
  policy_arns = [
    aws_iam_policy.lambda_exec.arn,
  ]
}

resource "aws_iam_policy" "lambda_exec" {
  name = "lambda_exec"
  path = "/system/"
  policy = data.aws_iam_policy_document.lambda_exec_log_policy.json
}

data "aws_iam_policy_document" "lambda_exec_log_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "${aws_cloudwatch_log_group.lambda.arn}:*",
    ]
  }
}
