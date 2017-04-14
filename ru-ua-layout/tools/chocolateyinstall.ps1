$ErrorActionPreference = 'Stop';

$packageName= 'ru-ua-layout'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/derwasp/chocolatey.packages/raw/d254eabd06865bf77b67889022e7508ce7aed59f/bin/lay-r-u_i386.zip'
$url64      = 'https://github.com/derwasp/chocolatey.packages/raw/d254eabd06865bf77b67889022e7508ce7aed59f/bin/lay-r-u_amd64.zip'
$fileLocation = Join-Path $toolsDir 'setup.msi'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64
  file          = $fileLocation

  softwareName  = 'Русская (Типографская Бирмана + Украинские символы)*'

  checksum      = 'C012733C2D0F91CE7CD007940DE911C9'
  checksum64    = 'C1F39E7BD127D47F17ACED539A05C3AE'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyInstallPackage @packageArgs
