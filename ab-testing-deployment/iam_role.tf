resource "aws_iam_role" "lambda_edge" {
  name = "AWSLambdaEdgeRole"
  path = "/service-role/"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "edgelambda.amazonaws.com",
            "lambda.amazonaws.com",
          ]
        },
        "Action" : "sts:AssumeRole",
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_edge" {
  name = "AWSLambdaEdgeInlinePolicy"
  role = aws_iam_role.lambda_edge.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource : [
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })
}
