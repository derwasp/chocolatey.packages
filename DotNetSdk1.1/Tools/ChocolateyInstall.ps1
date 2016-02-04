$packageName = 'DotNetSdk1.1'
$fileType = 'exe'
$silentArgs = '/Q /c:"install.exe /qb"'
$validExitCodes = @(0)
$url = 'https://download.microsoft.com/download/5/2/0/5202f918-306e-426d-9637-d7ee26fbe507/setup.exe'

$packageId = "{EB9BD1D5-8DFB-48C4-927B-10BB47CA59B3}"

if((get-wmiobject Win32_Product | ?{$_.IdentifyingNumber -eq $packageId}) -eq $null) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url -ValidExitCodes $validExitCodes
}
else {
     Write-Host ".NET Framework SDK Version 1.1 is already installed on your machine."
 }