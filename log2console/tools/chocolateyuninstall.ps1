$ErrorActionPreference = 'Stop';

$packageName = 'log2console'
$msiProductCodeGuid = '{F1805B06-194C-4278-9030-CA22C566CED0}'
$installerType = 'MSI' 
$silentArgs = "$msiProductCodeGuid /qn /norestart"
$validExitCodes = @(0, 3010, 1605, 1614, 1641)

Uninstall-ChocolateyPackage -PackageName $packageName `
                            -FileType $installerType `
                            -SilentArgs $silentArgs `
                            -ValidExitCodes $validExitCodes