param(
    [switch]$DryRun,
    [switch]$Override,
    [switch]$Help
)

if ($Help) {
    Write-Host "\nUsage:"
    Write-Host "  .\\install.ps1 [-DryRun] [-Override] [-Help]"
    Write-Host "\nOptions:"
    Write-Host "  -DryRun    Show what would be done, but don't make changes."
    Write-Host "  -Override  Overwrite existing files when creating symlinks."
    Write-Host "  -Help      Show this help message."
    exit 0
}

# Ensure we are running from the script's directory
$scriptRoot = $PSScriptRoot

# Dot-source setup.ps1
. "$scriptRoot\setup.ps1"

Write-Host "[install.ps1] Syncing repository..."
Sync-Repo -DryRun:$DryRun

Write-Host "[install.ps1] Installing or updating apps..."
Check-Apps -DryRun:$DryRun

Write-Host "[install.ps1] Installing or updating PowerShell modules..."
Install-Or-Update-PwshModules -DryRun:$DryRun

Write-Host "[install.ps1] Setting up symlinks..."
# Set up symlinks from repo root to user profile
$repoRoot = Split-Path $scriptRoot -Parent
$userProfile = [Environment]::GetFolderPath('UserProfile')
Setup-Symlinks -SourceDir $repoRoot -TargetDir $userProfile -DryRun:$DryRun -Override:$Override

Write-Host "[install.ps1] Done."
