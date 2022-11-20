
param (
    [Parameter(Mandatory = $true)]
    [ValidateSet(
        "us-east-2",
        "us-east-1",
        "us-west-1",
        "us-west-2",
        "af-south-1",
        "ap-east-1",
        "ap-southeast-3",
        "ap-south-1",
        "ap-northeast-3",
        "ap-northeast-2",
        "ap-northeast-1",
        "ca-central-1",
        "eu-central-1",
        "eu-west-1",
        "eu-west-2",
        "eu-south-1",
        "eu-west-3",
        "eu-north-1",
        "eu-central-2",
        "me-south-1",
        "me-central-1",
        "sa-east-1",
        "us-gov-east-1",
        "us-gov-west-1"
    )]
    $Region,
    [string[]]$Owner,
    [Parameter(Mandatory = $true)]
    [ValidateSet("plan","apply","destroy")]
    [string[]]$Action
)


$data = Invoke-WebRequest -Uri "http://ipinfo.io/ip" -Method Get 
$ssh_ip = $data.Content
$ip = "$ssh_ip/32"

$tfvars = @'
region="rg-replace"
owner="own-replace"
source_ip=["ip-replace"]
'@

$tfvars -replace ("rg-replace",$Region)`
        -replace ("own-replace",$Owner)`
        -replace ("ip-replace",$ip) | Out-File -FilePath .\temp.tfvars -Encoding ascii 

terraform.exe $Action -var-file temp.tfvars 


