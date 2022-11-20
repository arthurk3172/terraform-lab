output "sgr-web-id" {
  value = aws_security_group.sgr-web.id
}

output "sgr-rdp-id" {
  value = aws_security_group.sgr-rdp.id

}

output "ssm-enpoint-sgr-id" {
  value = aws_security_group.sgr-ssm.id

}
