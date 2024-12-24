resource "aws_lambda_function" "increment_lambda" {
  filename      = "increment_payload.zip"
  function_name = "increment"
  handler       = "increment.lambda_handler"
  role          = aws_iam_role.iam_for_lambda.arn

  source_code_hash = data.archive_file.increment.output_base64sha256

  runtime = "python3.12"

  environment {
    variables = {
      name = "Increment view count"
    }
  }
}

data "archive_file" "increment" {
  type        = "zip"
  source_file = "increment.py"
  output_path = "increment_payload.zip"
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
          "dynamodb:GetItem",
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


