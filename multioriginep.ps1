# ***************************************************************************
# * (C) Rackspace 2021      -       fabian.salamanca@rackspace.com          *
# * Usage: ./multioriginep.ps1                                              *
# * Azure PowerShell Module must be installed:                              *
# * Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force *
# ***************************************************************************
param(
	[string]$ResourceGroup = "defaultrg" ,
	[string]$CdnProfile = "defaultendpoint" ,
	[string]$Endpoint = "defaultendpoint" ,
	[string]$OriginGroup = "TestOG",
	[string]$Origin1 = "origin1",
	[string]$Origin2 = "origin2",
	[string]$Hostname2 = "www.kernel.org" )

# Check if user is logged in
$account = Get-AzContext

if(($null -eq $account) -or ($account -eq "")) {
	Connect-AzAccount 
}

#Connect-AzAccount

Write-Output "Checking: $account"

$location = "EastUS"
$subid = "xyxyxy-xyxyxyxy-xyxyxyxy-xyxyxyxy010101" # Must define your subscription ID here

Write-Output "Using parameters:"
Write-Output "$ResourceGroup `n`r$CdnProfile`n`r$Endpoint`n`r$OriginGroup`n`r$Origin1`n`r$Origin2`n`r$Hostname2"

#New-AzResourceGroup -Name $cdnrg -Location "East US"
#New-AzCdnProfile -Location $location -ProfileName $cdnname -ResourceGroupName $cdnrg -Sku Standard_Microsoft
#$CdnEndpoint = New-AzCdnEndpoint -EndpointName $cdnep -ProfileName $cdnname -ResourceGroupName $cdnrg -Location $location -OriginName Origin1 -OriginHostName rackspace.com
$CdnEndpoint = Get-AzCdnEndpoint -EndpointName $Endpoint -ProfileName $CdnProfile -ResourceGroupName $ResourceGroup
$CdnOrigin1 = Get-AzCdnOrigin -EndpointName $Endpoint -ProfileName $CdnProfile -ResourceGroupName $ResourceGroup
$CdnOriginGroup = New-AzCdnOriginGroup -ResourceGroupName $ResourceGroup -ProfileName $CdnProfile -EndpointName $Endpoint -OriginGroupName $OriginGroup -OriginId $CdnOrigin1.Id
$CdnEndpoint.DefaultOriginGroup = $CdnOriginGroup.Id
Set-AzCdnEndpoint -CdnEndpoint $CdnEndpoint
$CdnOrigin2 = New-AzCdnOrigin -ResourceGroupName $ResourceGroup -ProfileName $CdnProfile -EndpointName $Endpoint -OriginName $Origin2 -HostName $Hostname2
Set-AzCdnOriginGroup -EndpointName $Endpoint -OriginGroupName $OriginGroup -ProfileName $CdnProfile -ResourceGroupName $ResourceGroup -OriginId /subscriptions/$subid/resourcegroups/$ResourceGroup/providers/Microsoft.Cdn/profiles/$CdnProfile/endpoints/$Endpoint/origins/$Origin1, /subscriptions/$subid/resourcegroups/$ResourceGroup/providers/Microsoft.Cdn/profiles/$CdnProfile/endpoints/$Endpoint/origins/$Origin2
 
