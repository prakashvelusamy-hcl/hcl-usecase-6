module "ec2" {
    source = "./modules/terraform-aws-ec2"
    public_instance = var.public_instance
}