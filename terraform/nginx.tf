module "nginx-proxyr" {
  source         = "./modules/nginx"
  ami            = "ami-0574da719dca65348"
  instance_type_nginx = "t2.micro"
  subnet_id      = module.networking.public_subnet_ids[0]
  env   = var.env
  vpc_id = module.networking.vpc_id
  nginx_private_ip = var.nginx_private_ip
}

