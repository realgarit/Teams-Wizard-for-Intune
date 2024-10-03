$ClientID = "61c9ddea-d334-418a-bde3-b064e4f7dac6"
$RedirectURI = "msal61c9ddea-d334-418a-bde3-b064e4f7dac6://auth"
$PackageType = "EXE"
$PackageName = "Teams Wizard v0.6.7"
$DownloadURL = "https://github.com/patriklleshaj/Teams-Wizard-for-Intune/raw/refs/heads/main/Apps/TeamsWizard_x64.msi"
$TenantName = "alzch.onmicrosoft.com"
$Assignment = "g_devices_testing"
$InstallArgs = 'msiexec /i ALLUSERS=1 REBOOT=ReallySuppress /l*v "%Temp%\TeamsWizard_Install.log"'
$UninstallArgs  = "msiexec /x /qn {8E72BB19-BE2D-4A5A-AA39-839513CF1E11}"
$DetectionArgs = @"
Get-WmiObject -Class Win32_Product | Where {`$_.Vendor -eq 'LyncWizard.com' -and `$_.Version -eq '0.6.7'}
"@

.\Tool_IntuneDevOpsPackaging.ps1 -ClientID $ClientID `
                                        -RedirectURI $RedirectURI `
                                        -PackageType $PackageType `
                                        -PackageName $PackageName `
                                        -DownloadURL $DownloadURL `
                                        -TenantName $TenantName `
                                        -Assignment $Assignment `
                                        -InstallArgs $InstallArgs `
                                        -UninstallArgs $UninstallArgs `
                                        -DetectionArgs $DetectionArgs
