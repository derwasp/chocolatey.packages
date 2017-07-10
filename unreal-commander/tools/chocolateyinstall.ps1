$ErrorActionPreference = 'Stop';

$packageName= 'unreal-commander'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://unrealcommander.biz/download/evolution/uncomsetup3.57(build1222).exe'
$checksum   = '3857573EE7072CF9A16970194F4CCDF5'

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