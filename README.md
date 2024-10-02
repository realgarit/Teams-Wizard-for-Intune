# Teams Wizard Intune Packaging

This repository contains half automated scripts for packaging and deploying applications using **Microsoft Intune**. The solution includes a streamlined PowerShell script to package Win32 apps, manage installation arguments, and configure registry settings.

---

## Features

- 🛠 **Automated Packaging:** Automate packaging of `.exe` or `.msi` installers for deployment via Intune.
- ⚙️ **Custom Installation & Uninstallation:** Use customizable installation and uninstallation arguments.
- 📜 **Registry Modifications:** Apply specific registry configurations to ensure custom app settings are applied after deployment.
- 📝 **Logging:** Enable detailed logging for tracking installation progress.

---

## Contact Lookup Patterns Configuration

The configuration for `ContactLookupPatterns` in the registry is crucial for how phone numbers are handled within the application. 

### Why the Configuration?

In Switzerland, mobile numbers and landline numbers have distinct formats, and we want to ensure that both types of numbers are correctly processed by the Teams Wizard app.

- **Mobile Numbers**: Mobile numbers in Switzerland start with `+4175`, `+4176`, `+4177`, `+4178`, and `+4179`.
- **Landline Numbers**: Landline numbers start with other prefixes, so we need to handle them differently.

The following registry configuration allows the application to recognize and format mobile and landline numbers accordingly:

```plaintext
[HKEY_CURRENT_USER\SOFTWARE\LyncWizard.com\Teams Wizard\v1.0]
"ContactLookupPatterns"="1:\"^\\+41(7[5-9]\\d+)$\":0:\"0$1\""
"ContactLookupPatterns"="1:\"^\\+41(?!7[5-9])(\\d+)$\":3:\"0$1\""
```

## Usage

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/patriklleshaj/Teams-Wizard-for-Intune.git
    cd TeamsWizard-IntunePackaging
    ```

2. **Run the packaging script**:
    ```powershell
    ﻿$PackageType = "EXE"
    $PackageName = "Teams Wizard v0.6.7"
    $DownloadURL = "https://github.com/patriklleshaj/Teams-Wizard-for-Intune/blob/7b4313bf017d11ac8d668973a58b44630b436544/Apps/TeamsWizard_x64.msi"
    $TenantName = "example.omicrosoft.com"
    $Assignment = "g_devices_testing"
    $InstallArgs = 'msiexec /i ALLUSERS=1 REBOOT=ReallySuppress /l*v "%Temp%\TeamsWizard_Install.log"'
    $UninstallArgs  = "msiexec /x /qn {8E72BB19-BE2D-4A5A-AA39-839513CF1E11}"
    $DetectionArgs = @"
    Get-WmiObject -Class Win32_Product | Where {`$_.Vendor -eq 'LyncWizard.com' -and `$_.Version -eq '0.6.7'}
    "@
    
    .\TeamsWizard_packaging.ps1 -PackageType $PackageType `
                                            -PackageName $PackageName `
                                            -DownloadURL $DownloadURL `
                                            -TenantName $TenantName `
                                            -Assignment $Assignment `
                                            -InstallArgs $InstallArgs `
                                            -UninstallArgs $UninstallArgs `
                                            -DetectionArgs $DetectionArgs
    ```
3. **Don't forget to add your API Key in the value field for tel.search.ch for contact lookups**

4. **Upload the configuration script to Intune**


---

## Registry Configuration Example

The following registry settings will be applied automatically after app deployment:

![image](https://github.com/user-attachments/assets/4ffa4241-1d2a-4540-9c6f-431a46c38426)

