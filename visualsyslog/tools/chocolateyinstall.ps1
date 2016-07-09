$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName      = 'visualsyslog'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://raw.githubusercontent.com/MaxBelkov/visualsyslog/af0900313bfdc1faca335eef0db9d093c114520c/Output/visualsyslog_setup.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

  softwareName  = 'Visual Syslog*'
}

Install-ChocolateyPackage @packageArgs