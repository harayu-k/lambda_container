resource "aws_lambda_function" "test_lambda" {
  function_name = "ruby_lambda_test"
  role          = aws_iam_role.lambda_exec.arn
  package_type = "Image"
  image_uri = data.aws_ecr_image.service_image.image_uri
  architectures = ["arm64"]

  lifecycle {
    ignore_changes = [image_uri]
  }
}



data "aws_ecr_image" "service_image" {
  repository_name = "lambda"
  image_tag       = "initial"
}
