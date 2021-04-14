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
Write-Host "The Host Recorder`n"

Write-Host "[+] Executing 'vagrant up', this may take a while on first run while we fetch Vagrant boxes for Kali & Server 2016."
Set-Location .\vagrant
$VagrantOutput = vagrant up
Set-Location ..

Write-Host $VagrantOutput