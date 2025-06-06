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
    public_instance_ids = module.vpc.public_subnet_ids
}