$ErrorActionPreference = 'Stop';

$packageName= 'unreal-commander'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://unrealcommander.com/download/evolution/uncomsetup3.57(build1223).exe'
$checksum   = '5F6CF7AE8E79DAEB04A607FEC185EA56'

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