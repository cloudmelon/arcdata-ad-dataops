
Add-DnsServerPrimaryZone -NetworkId "10.0.10.0/16" -ReplicationScope Domain

# Get reverse zone name
$Zones = @(Get-DnsServerZone)
ForEach ($Zone in $Zones) {
    if (-not $($Zone.IsAutoCreated) -and ($Zone.IsReverseLookupZone)) {
        $Reverse = $Zone.ZoneName
    }
}

Add-DNSServerResourceRecordPTR -ZoneName $Reverse -Name 10 -PTRDomainName azdc.contoso.local 

# user calculator https://mxtoolbox.com/subnetcalculator.aspx