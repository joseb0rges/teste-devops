module "networking" {
  source         = "./modules/networking"
  vpc_cidr_block = "10.20.0.0/20" 
  public_subnets = [
    { cidr_block = "10.20.2.0/23", zone = "${var.region}a", name = "subnet-a-pub1" },
    { cidr_block = "10.20.6.0/23", zone = "${var.region}b", name = "subnet-b-pub1" },
    { cidr_block = "10.20.10.0/23", zone = "${var.region}c", name = "subnet-c-pub1" }
  ]
  customer_group = var.customer_group
  env            = var.env
  
}
