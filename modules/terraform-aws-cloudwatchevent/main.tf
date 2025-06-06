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
