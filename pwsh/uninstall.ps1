param(
    [switch]$DryRun,
    [switch]$Help
)

if ($Help) {
    Write-Host "\nUsage:"
    Write-Host "  .\\uninstall.ps1 [-DryRun] [-Help]"
    Write-Host "\nOptions:"
    Write-Host "  -DryRun   Show what would be done, but don't make changes."
    Write-Host "  -Help     Show this help message."
    exit 0
}

# Ensure we are running from the script's directory
$scriptRoot = $PSScriptRoot

# Dot-source setup.ps1
. "$scriptRoot\setup.ps1"

Write-Host "[uninstall.ps1] Uninstalling apps..."
Uninstall-Apps -DryRun:$DryRun

Write-Host "[uninstall.ps1] Uninstalling PowerShell modules..."
Uninstall-PwshModules -DryRun:$DryRun

Write-Host "[uninstall.ps1] Uninstall complete."
