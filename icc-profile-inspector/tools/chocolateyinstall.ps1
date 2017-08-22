$ErrorActionPreference = 'Stop';

$packageName= 'icc-profile-inspector'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.color.org/ICCProfileInspector2_4.zip'

$fileLocation = Join-Path $toolsDir 'ICCProfileInspector.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'ICC Profile Inspector 2.4.0'
  file          = $fileLocation

  checksum      = '0A443E5F6FA7B26F19513C49F5A703BA'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyInstallPackage @packageArgs
