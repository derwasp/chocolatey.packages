$ErrorActionPreference = 'Stop';

$packageName= 'unreal-commander'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://unrealcommander.org/download/evolution/uncomsetup3.57(build1212).exe'
$checksum   = '5EB22C4B36FFBDDC558AC3391E980AE1'

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