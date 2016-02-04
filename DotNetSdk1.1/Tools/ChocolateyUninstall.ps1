$ErrorActionPreference = 'Stop';

$packageName = 'DotNetSdk1.1'
$msiProductCodeGuid = '{EB9BD1D5-8DFB-48C4-927B-10BB47CA59B3}'
$installerType = 'MSI' 
$silentArgs = "$msiProductCodeGuid /qn /norestart"
$validExitCodes = @(0, 3010, 1605, 1614, 1641)

Uninstall-ChocolateyPackage -PackageName $packageName `
                            -FileType $installerType `
                            -SilentArgs $silentArgs `
                            -ValidExitCodes $validExitCodes