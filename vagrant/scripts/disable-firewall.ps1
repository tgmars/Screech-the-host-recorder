Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Disabling Windows firewall"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False