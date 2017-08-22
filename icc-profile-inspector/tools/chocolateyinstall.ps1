$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName= 'icc-profile-inspector' # arbitrary name for the package, used in messages
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.color.org/ICCProfileInspector2_4.zip' # download url, HTTPS preferred

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$installDir = $toolsPath
if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "ICC Profile Inspector is going to be installed in '$installDir'"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installDir
  url           = $url
  checksum      = '0A443E5F6FA7B26F19513C49F5A703BA'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
}

Install-ChocolateyZipPackage @packageArgs
