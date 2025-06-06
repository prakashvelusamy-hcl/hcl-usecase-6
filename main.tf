module "vpc" {
  source   = "./modules/terraform-aws-vpc"
  vpc_cidr = var.vpc_cidr
  pub_sub_count  = var.pub_sub_count
  priv_sub_count = var.priv_sub_count
  nat_count      = var.nat_count
}
module "ec2" {
    source = "./modules/terraform-aws-ec2"
    public_instance = var.public_instance
    vpc_id = module.vpc.vpc_id
    public_subnet_ids=module.vpc.public_subnet_ids
}

module "lambda" {
    source = "./modules/terraform-aws-lambda"
    #instance_id = var.instance_id
    instance_start_time = var.instance_start_time
    instance_stop_time = var.instance_stop_time
    public_instance_ids = module.ec2.public_instance_ids
}