$ErrorActionPreference = 'Stop';

$packageName= 'log2console'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=log2console&DownloadId=1484720&FileTime=130867919671770000&Build=21031'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url           = $url

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/quiet /qn'

  softwareName  = 'log2console*'
}

Install-ChocolateyPackage @packageArgs