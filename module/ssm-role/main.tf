#..............IAM Roles and Policies................................

//Assume Policy
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

//Create Role 
resource "aws_iam_role" "role-ec2-ssm" {
  name               = "role-ec2-${var.owner}-ssm"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

//Atach Policy to Role 
resource "aws_iam_policy_attachment" "ec2-ssm-policy-role-atach" {
  name       = "ec2-ssm-policy-role-atach"
  roles      = [aws_iam_role.role-ec2-ssm.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

//Create Instance Profile 
resource "aws_iam_instance_profile" "ssm-profile" {
  name = "ssm-${var.owner}-ec2-profile"
  role = aws_iam_role.role-ec2-ssm.name
}


