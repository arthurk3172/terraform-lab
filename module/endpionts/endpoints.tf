#....................Create EndPoints for SSM Manage ec2 in private subnet..................



resource "aws_vpc_endpoint" "vpce-ssm" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    var.security_group_ids
  ]

  subnet_ids = var.subnet_ids

  tags = {
    "Name" = "vpce-${var.owner}-ssm"
  }

}



resource "aws_vpc_endpoint" "vpce-ssm-messages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    var.security_group_ids
  ]

  subnet_ids = var.subnet_ids

  tags = {
    "Name" = "vpce-${var.owner}-ssm-messages"
  }

}



resource "aws_vpc_endpoint" "vpce-arthurk-ssm-ec2-messages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    var.security_group_ids
  ]

  subnet_ids = var.subnet_ids

  tags = {
    "Name" = "vpce-${var.owner}-ssm-ec2-messages"
  }

}




