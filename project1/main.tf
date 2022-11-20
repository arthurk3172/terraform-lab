provider "aws" {
  region     = var.region
  access_key = "your access key"
  secret_key = "your secret key"
}


module "vpc-default" {
  source = "../module/network"
  owner  = var.owner
  region = var.region
}

module "sgr-default" {
  source        = "../module/sgr"
  vpc_id        = module.vpc-default.vpc_id
  ssh_source_ip = var.source_ip
  depends_on = [
    module.vpc-default
  ]
}

module "ssm-role-default" {
  source = "../module/ssm-role"

}

//Web Linux Instance
resource "aws_instance" "web_server" {
  count                       = length(module.vpc-default.public_subnet_ids) //Count of servers depends on subnets count, each subnet will have 1 server 
  ami                         = data.aws_ami.ubuntu_ami.id
  instance_type               = var.web_server_instance_type
  subnet_id                   = module.vpc-default.public_subnet_ids[count.index] //element("${module.vpc-default.public_subnet_ids[*].id}", count.index)
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key-arthur.key_name
  vpc_security_group_ids      = [module.sgr-default.sgr-web-id]
  user_data                   = file("userdata.sh")

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp3"
    volume_size           = 20
  }
  tags = {
    "Name"        = "i-${var.owner}-lnx-terraform-web-server${count.index + 1}"
    "Description" = "This is terraform test Web-Linux instance"
  }
}

//Windows 2019 Instance 
resource "aws_instance" "rdp_server" {
  count                       = length(module.vpc-default.private_subnet_ids)
  ami                         = data.aws_ami.windows2019_ami.id
  instance_type               = var.rdp_windows_srv_instance_type
  subnet_id                   = module.vpc-default.private_subnet_ids[count.index] //element(aws_subnet.private_subnets[*].id, count.index)
  associate_public_ip_address = false
  key_name                    = aws_key_pair.key-arthur.key_name
  vpc_security_group_ids      = [module.sgr-default.sgr-rdp-id]
  iam_instance_profile        = module.ssm-role-default.ssm-profile-name

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp3"
    volume_size           = 30
  }
  tags = {
    "Name"        = "i-${var.owner}-windows-2019-terminal-terraform${count.index + 1}"
    "Description" = "This is terraform Windows Terminal instance"
  }
}


module "ssm-endpoints" {
  source             = "../module/endpionts"
  vpc_id             = module.vpc-default.vpc_id
  subnet_ids         = module.vpc-default.private_subnet_ids
  security_group_ids = module.sgr-default.ssm-enpoint-sgr-id
}

