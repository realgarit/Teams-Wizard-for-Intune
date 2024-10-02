# Set registry path
$RegPath = "HKCU:\SOFTWARE\LyncWizard.com\Teams Wizard\v1.0"

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set the registry values

# String values (REG_SZ)
Set-ItemProperty -Path $RegPath -Name "APIKey" -Value ""
