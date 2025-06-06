## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/terraform-aws-ec2 | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./modules/terraform-aws-lambda | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/terraform-aws-vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_start_time"></a> [instance\_start\_time](#input\_instance\_start\_time) | The time instance need to be start | `string` | n/a | yes |
| <a name="input_instance_stop_time"></a> [instance\_stop\_time](#input\_instance\_stop\_time) | The time instance need to be stopped | `string` | n/a | yes |
| <a name="input_nat_count"></a> [nat\_count](#input\_nat\_count) | Number of NAT gateways | `number` | n/a | yes |
| <a name="input_priv_sub_count"></a> [priv\_sub\_count](#input\_priv\_sub\_count) | Number of private subnets | `number` | n/a | yes |
| <a name="input_pub_sub_count"></a> [pub\_sub\_count](#input\_pub\_sub\_count) | Number of public subnets | `number` | n/a | yes |
| <a name="input_public_instance"></a> [public\_instance](#input\_public\_instance) | Number of public EC2 instances to create | `number` | n/a | yes |
| <a name="input_public_instance_ids"></a> [public\_instance\_ids](#input\_public\_instance\_ids) | Instance ID we want to stop and start | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ID"></a> [instance\_ID](#output\_instance\_ID) | n/a |
