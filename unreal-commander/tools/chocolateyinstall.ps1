$ErrorActionPreference = 'Stop';

$packageName= 'unreal-commander'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://x-diesel.net/download/evolution/uncomsetup3.57(build1209).exe'
$checksum   = 'A4B09558828AE146633E0AEF58F3D7D7'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  checksum      = $checksum
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

  softwareName  = 'Unreal Commander*'
}

Install-ChocolateyPackage @packageArgs