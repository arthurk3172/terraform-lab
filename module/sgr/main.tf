



//Web server Security Group
resource "aws_security_group" "sgr-web" {
  name        = "sgr-${var.owner}-web"
  description = "${var.owner} web server security group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sgr_web_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_source_ip //Change to User defined variable
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Windows Terminal Security Group
resource "aws_security_group" "sgr-rdp" {
  name        = "sgr-${var.owner}-rdp"
  description = "${var.owner} RDP server security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#SSM Endpoints Security Group
resource "aws_security_group" "sgr-ssm" {
  name        = "sgr-${var.owner}-ssm"
  description = "${var.owner} SSM Endpoint security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.sgr-rdp.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
