resource "aws_lambda_function" "increment_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "increment"
  handler       = "script.lambda_handler"
  role          = aws_iam_role.iam_for_lambda.arn

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.12"

  environment {
    variables = {
      name = "Increment view count"
    }
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "lamdba_policy" {
  name = "lambda_dynamodb_role"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:UpdateItem",
          "dynamodb:PutItem",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lamdba_policy.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "script.py"
  output_path = "lambda_function_payload.zip"
}
