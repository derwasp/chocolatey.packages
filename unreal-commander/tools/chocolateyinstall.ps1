$ErrorActionPreference = 'Stop';

$packageName= 'unreal-commander'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://x-diesel.net/download/evolution/uncomsetup3.57(build1206).exe'
$checksum   = 'AC8C3B127CD27318D965428B6F846083'

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