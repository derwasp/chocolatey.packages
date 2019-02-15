$ErrorActionPreference = 'Stop';

$packageName= 'log2console'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://raw.githubusercontent.com/Statyk7/log2console/2d81188a3799ae9de0f469dc9260075d8d17d2fb/output/Log2Console-1.6.0.2.msi'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url           = $url

  checksum      = '54202EFF5754FA4275EFDEC030470B47'

  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn'

  softwareName  = 'log2console*'
}

Install-ChocolateyPackage @packageArgs