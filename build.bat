@echo off
cls
pushd %~dp0
if not exist ".\packages\FAKE\TOOLS\FAKE.exe" "NuGet.exe" "Install" "FAKE" "-ExcludeVersion" "-OutputDirectory" "packages"
"packages\FAKE\tools\Fake.exe" build.fsx %*
popd