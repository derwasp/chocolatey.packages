$ErrorActionPreference = 'Stop';

$packageName= 'icc-profile-inspector'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.color.org/ICCProfileInspector2-4.zip'

$fileLocation = Join-Path $toolsDir 'ICCProfileInspector/ICCProfileInspector.exe'

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

# from https://chocolatey.org/packages/veracrypt
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "icc-profile-inspectorinstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru
 
$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyInstallPackage @packageArgs
