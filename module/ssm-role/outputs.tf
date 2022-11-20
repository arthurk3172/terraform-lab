output "ssm-role-id" {
  value = aws_iam_role.role-ec2-ssm.id

}

output "ssm-instance-profile-id" {
  value = aws_iam_instance_profile.ssm-profile.id

}


output "ssm-profile-name" {
  value = aws_iam_instance_profile.ssm-profile.name

}

