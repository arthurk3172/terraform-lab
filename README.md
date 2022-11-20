# terraform-lab

Made by Arthur Kandinov

This is test lab for automated infrastucture as code on AWS platform using Terraform. 
The automation will create 1 VPC and 4 subnets( 2 -public and 2 private) each public and private subnet set will be created in separate AZs.
Will deployed 4 Servers (1 per subnet):

  * 2 Linux Ubuntu Servers in public subnets will be deployed with Zabbix 6.2 Monitoring system using docker containers(docker-compose) - YAML file of compose was premade by me and uploaded to git.  
  * 2 Windows Server 2019 in private subnets for RDP 
	
Will create relates Security groups and route tables.
will create Endpoints atached to private subnets for ssm managment support of Windows Servers in Private subnets (RDP connection will be available via Fleet Manager) 
The Powershell script will create tfvars file with variables that defined in flags + source ip(your external ip) will be added to variables to use it in Security Group definition for ssh connection to web servers.
Teraform on deploy will create keypair in aws and will download private pem file to project1 directory - you will use it for connection via ssh or Fleet Manager RDP

Requarements : 
On linux: 
Powerhsell + Terraform must be installed 

On windows : Only Terraform must be installed. 

Before usage:
 You must define your access key and secret key using one of those options:
  1. Export to enviroment variables that terraform using for connection(check terrafom documetation how to)
  2. Configure it via installed aws cli console (if you have aws cli installed - check out aws documentation how to)
  3. Paste it to project1/main.tf file in provider section (Not Recomended due Security propose)


Usage : 
The "terraform-apply.ps1" script supports flags:
    Mandatory flag -Region (Entry validation with list of all available Regions in AWS, you can use TAB to switch elements in list or autocomplete)
    Mandatory flag -Action (List of 3 actions - "apply" or "plan" or "apply")
    Optional flag -Owner (Owners Name - will create resources with practicular name in resource (Tags) if not defined default variable "arthurk" will be used instead)

Clone via git or download zip to your computer
Switch to "project1" folder and start deploy infastructure via ps script terraform-apply.ps1 

Example: terraform-apply.ps1 -Action plan -Region us-west-1 -Owner Arthur
