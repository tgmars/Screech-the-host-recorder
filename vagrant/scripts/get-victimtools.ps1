# Shamelessly taken from https://github.com/clong/DetectionLab/blob/master/Vagrant/scripts/install-utilities.ps1
# modified to install procmon via chocolatey. 

If (-not (Test-Path "C:\ProgramData\chocolatey")) {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Installing Chocolatey"
    Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
  } else {
    Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Chocolatey is already installed."
  }
  
  Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Installing utilities..."

  choco install -y --limit-output --no-progress procmon
  
  Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Utilties installation complete!"