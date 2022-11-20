output "endpoint-ssm-id" {
  value = aws_vpc_endpoint.vpce-ssm.id
}

output "endpoint-ssm-messages-id" {
  value = aws_vpc_endpoint.vpce-ssm-messages.id

}

output "endpoint-ssm-ec2-messages-id" {
  value = aws_vpc_endpoint.vpce-arthurk-ssm-ec2-messages.id

}
