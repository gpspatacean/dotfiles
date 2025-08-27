# Map of AppName to Winget Id
$AppIdMap = @{
    "oh-my-posh" = "JanDeDobbeleer.OhMyPosh"
    "fzf"        = "junegunn.fzf"
    "zoxide"     = "ajeetdsouza.zoxide"
    "eza"        = "eza-community.eza"
    "bat"        = "sharkdp.bat"
    "yazi"       = "sxyazi.yazi"
    "rg"         = "BurntSushi.ripgrep.MSVC"
    "lazygit"    = "JesseDuffield.lazygit"
}

function Install-Or-Update-App {
    param(
        [string]$AppName,
        [string]$WingetId,
        [switch]$DryRun
    )
    $appCmd = Get-Command $AppName -ErrorAction SilentlyContinue
    if ($appCmd) {
        Write-Host "'$AppName' found. Attempting to update..."
        if ($DryRun) {
            Write-Host "[Dry-Run] Would run: winget upgrade --id $WingetId --exact"
        } else {
            winget upgrade --id $WingetId --exact
        }
    } else {
        Write-Host "'$AppName' not found. Installing..."
        if ($DryRun) {
            Write-Host "[Dry-Run] Would run: winget install --id $WingetId --exact"
        } else {
            winget install --id $WingetId --exact
        }
    }
}

function Check-Apps {
    param(
        [switch]$DryRun
    )
    foreach ($app in $AppIdMap.Keys) {
        $id = $AppIdMap[$app]
        Install-Or-Update-App -AppName $app -WingetId $id -DryRun:$DryRun
    }
}

function Uninstall-App {
    param(
        [string]$AppName,
        [string]$WingetId,
        [switch]$DryRun
    )
    $appCmd = Get-Command $AppName -ErrorAction SilentlyContinue
    if ($appCmd) {
        Write-Host "'$AppName' found. Attempting to uninstall..."
        if ($DryRun) {
            Write-Host "[Dry-Run] Would run: winget uninstall --id $WingetId --exact"
        } else {
            winget uninstall --id $WingetId --exact
        }
    } else {
        Write-Host "'$AppName' not found. Skipping uninstall."
    }
}

function Uninstall-Apps {
    param(
        [switch]$DryRun
    )
    foreach ($app in $AppIdMap.Keys) {
        $id = $AppIdMap[$app]
        Uninstall-App -AppName $app -WingetId $id -DryRun:$DryRun
    }
}

# Symlinks map: key = source (relative), value = target (relative)
$SymlinksMap = @{
    # Example:
    # '.vimrc' = '.config\vim\.vimrc'
    "customized_atomic.omp.json" = ".config\customized_atomic.omp.json"
    ".config\bat" = ".config\bat"
    ".config\git" = ".config\git"
    ".config\lazygit" = ".config\lazygit"
    ".config\nvim" = ".config\nvim"
    ".config\rg" = ".config\rg"
    ".config\yazi" = ".config\yazi"
    "pwsh\Microsoft.PowerShell_profile.ps1" = "Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}

function Create-Symlink {
    param(
        [Parameter(Mandatory=$true)][string]$Source,
        [Parameter(Mandatory=$true)][string]$Target,
        [switch]$DryRun,
        [switch]$Override
    )
    # If Source/Target are full paths, use as is; otherwise, make them relative to $PSScriptRoot
    if ([System.IO.Path]::IsPathRooted($Source)) {
        $fullSource = $Source
    } else {
        $fullSource = Join-Path -Path $PSScriptRoot -ChildPath $Source
    }
    if ([System.IO.Path]::IsPathRooted($Target)) {
        $fullTarget = $Target
    } else {
        $fullTarget = Join-Path -Path $PSScriptRoot -ChildPath $Target
    }
    if (Test-Path $fullTarget) {
        if ($Override) {
            $timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
            $backupPath = "$fullTarget.bak.$timestamp"
            Write-Host "Target '$fullTarget' already exists. Backing up to '$backupPath'."
            if ($DryRun) {
                Write-Host "[Dry-Run] Would run: 'Move-Item -Path ''$fullTarget'' -Destination ''$backupPath'' -Force'"
            } else {
                Move-Item -Path $fullTarget -Destination $backupPath -Force
            }
        } else {
            Write-Host "Target '$fullTarget' already exists. Skipping (use -Override to replace)."
            return
        }
    }
    # Ensure parent directory exists
    $parentDir = Split-Path -Path $fullTarget -Parent
    if (!(Test-Path $parentDir)) {
        if ($DryRun) {
            Write-Host "[Dry-Run] Would run: 'New-Item -ItemType Directory -Path ''$parentDir'' -Force'"
        } else {
            New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
        }
    }
    Write-Host "Creating symlink: '$fullTarget' -> '$fullSource'"
    if ($DryRun) {
        Write-Host "[Dry-Run] Would run: 'New-Item -ItemType SymbolicLink -Path ''$fullTarget'' -Target ''$fullSource'''"
    } else {
        New-Item -ItemType SymbolicLink -Path $fullTarget -Target $fullSource | Out-Null
    }
}

function Setup-Symlinks {
    param(
        [Parameter(Mandatory=$true)][string]$SourceDir,
        [Parameter(Mandatory=$true)][string]$TargetDir,
        [switch]$DryRun,
        [switch]$Override
    )
    foreach ($key in $SymlinksMap.Keys) {
        $source = Join-Path -Path $SourceDir -ChildPath $key
        $target = Join-Path -Path $TargetDir -ChildPath $SymlinksMap[$key]
        Create-Symlink -Source $source -Target $target -DryRun:$DryRun -Override:$Override
    }
}

# Example usage: install or update all apps in the map with dry-run enabled
# Check-Apps -DryRun
# Uninstall-Apps -DryRun
