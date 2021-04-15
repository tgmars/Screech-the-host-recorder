$Header = @"
.oooooo..o   .oooooo.   ooooooooo.   oooooooooooo oooooooooooo   .oooooo.   ooooo   ooooo 
d8P'    'Y8  d8P'  'Y8b  '888   'Y88. '888'     '8 '888'     '8  d8P'  'Y8b  '888'   '888' 
Y88bo.      888           888   .d88'  888          888         888           888     888  
 '"Y8888o.  888           888ooo88P'   888oooo8     888oooo8    888           888ooooo888  
     '"Y88b 888           888'88b.     888    "     888    "    888           888     888  
oo     .d8P '88b    ooo   888  '88b.   888       o  888       o '88b    ooo   888     888  
8""88888P'   'Y8bood8P'  o888o  o888o o888ooooood8 o888ooooood8  'Y8bood8P'  o888o   o888o
"@

Write-Host "Welcome to..."
Write-Host -ForegroundColor Green $Header
Write-Host "The host recorder`n"

Write-Host "[+] Executing 'vagrant up', this may take a while on first run while we fetch Vagrant boxes for Kali & Server 2016."
Write-Host "[+] Progress is stored in ./logs/vagrant.log"

if( (Test-Path "./logs/vagrant.log") -eq $false ){
    Out-File -FilePath "./logs/vagrant.log"
}

Write-Output "$('[{0:HH:mm}]' -f (Get-Date)) Vagrant up" | Out-File -FilePath "./logs/vagrant.log" -Append

# Start the vagrant environment
Set-Location .\vagrant
vagrant up | Out-File -FilePath "../logs/vagrant.log" -Append
Set-Location ..

# Ensure procmon isn't running. 
Write-Host "[+] Closing any running instances of procmon or procmon64"
Write-Output "$('[{0:HH:mm}]' -f (Get-Date)) Pre-closure of procmon to avoid conflicts." | Out-File -FilePath "./logs/vagrant.log" -Append
Set-Location .\vagrant
vagrant powershell victim -c "Get-Process 'procmon' | Stop-Process" | Out-File -FilePath "../logs/vagrant.log" -Append
vagrant powershell victim -c "Get-Process 'procmon64' | Stop-Process" | Out-File -FilePath "../logs/vagrant.log" -Append
Set-Location ..

# Start procmon on the victim
Write-Host "[+] Starting Procmon trace on victim."
Write-Output "$('[{0:HH:mm}]' -f (Get-Date)) Vagrant powershell victim" | Out-File -FilePath "./logs/vagrant.log" -Append
Set-Location .\vagrant
vagrant powershell victim -c "Procmon /AcceptEula /BackingFile C:\vagrant\$('{0:HHmm-dd-MMM}.pml /Runtime 10' -f (Get-Date)) /Quiet" | Out-File -FilePath "../logs/vagrant.log" -Append
Set-Location ..


# Terminate procmon on the victim
Write-Host "[+] Terminating Procmon"
Write-Output "$('[{0:HH:mm}]' -f (Get-Date)) Vagrant powershell victim - terminate procmon" | Out-File -FilePath "../logs/vagrant.log" -Append
vagrant powershell victim -c "Procmon /Terminate" | Out-File -FilePath "../logs/vagrant.log" -Append
vagrant powershell victim -c "Get-Process 'procmon' | Stop-Process" | Out-File -FilePath "../logs/vagrant.log" -Append
Set-Location ..
