Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Disabling Windows firewall"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Disabling UAC"
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
