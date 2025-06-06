resource "aws_iam_role" "lambda_ec2_control" {
  name = "lambda-ec2-control-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_ec2_policy" {
  name        = "lambda-ec2-policy"
  description = "Allow Lambda to start and stop EC2 instances and write logs"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ec2_attach" {
  role       = aws_iam_role.lambda_ec2_control.name
  policy_arn = aws_iam_policy.lambda_ec2_policy.arn
}



data "archive_file" "lambda_stop" {
  type        = "zip"
  source_file = "${path.module}/stop_lambda_function.py"
  output_path = "${path.module}/stop_lambda_function_payload.zip"
}

resource "aws_lambda_function" "stop_ec2_instances" {
function_name = "stop-ec2-instances"
role          = aws_iam_role.lambda_ec2_control.arn
handler       = "stop_lambda_function.lambda_handler"
runtime       = "python3.12"
filename      = "${path.module}/stop_lambda_function_payload.zip"
source_code_hash =  data.archive_file.lambda_stop.output_base64sha256
  environment {
     variables = {
     INSTANCE_ID = var.instance_id[0]
     }
}
}
data "archive_file" "lambda_start" {
  type        = "zip"
  source_file = "${path.module}/start_lambda_function.py"
  output_path = "${path.module}/start_lambda_function_payload.zip"
}

resource "aws_lambda_function" "start_ec2_instances" {
function_name = "start-ec2-instances"
role          = aws_iam_role.lambda_ec2_control.arn
handler       = "start_lambda_function.lambda_handler"
runtime       = "python3.12"
filename      = "${path.module}/start_lambda_function_payload.zip"
timeout       = 30
source_code_hash =  data.archive_file.lambda_start.output_base64sha256
  environment {
     variables = {
     INSTANCE_ID = var.instance_id[0]
     }
}
}





resource "aws_cloudwatch_event_rule" "stop_ec2_daily" {
  name                = "stop-ec2-daily"
  description         = "Triggers Lambda to stop EC2 instances daily"
  schedule_expression = var.instance_stop_time
  #schedule_expression = "cron(0 17 * * ? *)"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_ec2_instances.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_ec2_daily.arn
}

resource "aws_cloudwatch_event_target" "stop_trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.stop_ec2_daily.name
  target_id = "StopEC2Lambda"
  arn       = aws_lambda_function.stop_ec2_instances.arn
}


resource "aws_cloudwatch_event_rule" "start_ec2_daily" {
  name                = "start-ec2-daily"
  description         = "Triggers Lambda to start EC2 instances daily"
  #schedule_expression = "cron(0 08 * * ? *)" 
  schedule_expression = var.instance_start_time
}

resource "aws_lambda_permission" "allow_cloudwatch_start" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start_ec2_instances.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_ec2_daily.arn
}

resource "aws_cloudwatch_event_target" "start_trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.start_ec2_daily.name
  target_id = "StopEC2Lambda"
  arn       = aws_lambda_function.start_ec2_instances.arn
}
