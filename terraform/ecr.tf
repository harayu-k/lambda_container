resource "aws_ecr_repository" "lambda" {
  name                 = "lambda"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# resource "aws_ecr_repository_policy" "lambda" {
#   repository = aws_ecr_repository.lambda.name
#   policy =
# }
