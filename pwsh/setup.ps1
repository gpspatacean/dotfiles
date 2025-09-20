# $WingetAppIdsMap is a hashtable mapping application names to their corresponding Winget IDs.
# Used for automated install, update, and uninstall of applications via Winget.
$WingetAppIdsMap = @{
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
    <#
    .SYNOPSIS
        Installs or updates a given application using Winget.
    .PARAMETER AppName
        The name of the application.
    .PARAMETER WingetId
        The Winget ID of the application.
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    #>
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
    <#
    .SYNOPSIS
        Installs or updates all applications defined in $WingetAppIdsMap.
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    #>
    param(
        [switch]$DryRun
    )
    foreach ($app in $WingetAppIdsMap.Keys) {
        $id = $WingetAppIdsMap[$app]
        Install-Or-Update-App -AppName $app -WingetId $id -DryRun:$DryRun
    }
}

function Uninstall-App {
    <#
    .SYNOPSIS
        Uninstalls a given application using Winget.
    .PARAMETER AppName
        The name of the application.
    .PARAMETER WingetId
        The Winget ID of the application.
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    #>
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
    <#
    .SYNOPSIS
        Uninstalls all applications defined in $WingetAppIdsMap.
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    #>
    param(
        [switch]$DryRun
    )
    foreach ($app in $WingetAppIdsMap.Keys) {
        $id = $WingetAppIdsMap[$app]
        Uninstall-App -AppName $app -WingetId $id -DryRun:$DryRun
    }
}

# $SymlinksMap is a hashtable where each key is a relative source path and each value is a relative target path.
# Used to automate the creation of symbolic links for configuration files and directories.
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
    <#
    .SYNOPSIS
        Creates a symbolic link from source to target, backing up the target if it exists.
    .PARAMETER Source
        The source file or directory (relative or absolute path).
    .PARAMETER Target
        The target file or directory (relative or absolute path).
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    .PARAMETER Override
        If specified, backs up and replaces the target if it exists.
    #>
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
    <#
    .SYNOPSIS
        Iterates through $SymlinksMap and creates symlinks for each entry.
    .PARAMETER SourceDir
        The base directory for all source paths.
    .PARAMETER TargetDir
        The base directory for all target paths.
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    .PARAMETER Override
        If specified, backs up and replaces the target if it exists.
    #>
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

# $PwshModules is an array of PowerShell module names to be managed (install, update, uninstall).
$PwshModules = @(
    'PSFzf'
)

function Install-Or-Update-PwshModules {
    <#
    .SYNOPSIS
        Installs or updates all PowerShell modules listed in $PwshModules.
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    #>
    param(
        [switch]$DryRun
    )
    foreach ($module in $PwshModules) {
        if (Get-Module -ListAvailable -Name $module) {
            Write-Host "Module '$module' found. Attempting to update..."
            if ($DryRun) {
                Write-Host "[Dry-Run] Would run: Update-Module -Name '$module' -Force"
            } else {
                Update-Module -Name $module -Force
            }
        } else {
            Write-Host "Module '$module' not found. Installing..."
            if ($DryRun) {
                Write-Host "[Dry-Run] Would run: Install-Module -Name '$module' -Scope CurrentUser -Force"
            } else {
                Install-Module -Name $module -Scope CurrentUser -Force
            }
        }
    }
}

function Uninstall-PwshModules {
    <#
    .SYNOPSIS
        Uninstalls all PowerShell modules listed in $PwshModules.
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    #>
    param(
        [switch]$DryRun
    )
    foreach ($module in $PwshModules) {
        if (Get-Module -ListAvailable -Name $module) {
            Write-Host "Module '$module' found. Attempting to uninstall..."
            if ($DryRun) {
                Write-Host "[Dry-Run] Would run: Uninstall-Module -Name '$module' -AllVersions -Force"
            } else {
                Uninstall-Module -Name $module -AllVersions -Force
            }
        } else {
            Write-Host "Module '$module' not found. Skipping uninstall."
        }
    }
}

function Sync-Repo {
    <#
    .SYNOPSIS
        Syncs the current repository with the remote by checking out and pulling the specified branch.
    .PARAMETER Branch
        The branch to sync with. Defaults to 'master'.
    .PARAMETER DryRun
        If specified, logs the actions without executing them.
    #>
    param(
        [string]$Branch = "master",
        [switch]$DryRun
    )
    $originalLocation = Get-Location
    $repoLocation = $PSScriptRoot
    Write-Host "Syncing repository at '$repoLocation' with branch '$Branch'..."
    if ($DryRun) {
        Write-Host "[Dry-Run] Would run: Set-Location '$repoLocation'"
        Write-Host "[Dry-Run] Would run: git fetch --all"
        Write-Host "[Dry-Run] Would run: git checkout $Branch"
        Write-Host "[Dry-Run] Would run: git pull origin $Branch"
        Write-Host "[Dry-Run] Would run: Set-Location '$($originalLocation.Path)'"
    } else {
        try {
            Set-Location $repoLocation
            git fetch --all
            git checkout $Branch
            git pull origin $Branch
        } finally {
            Set-Location $originalLocation
        }
    }
}

# Example usage: install or update all apps in the map with dry-run enabled
# Check-Apps -DryRun
# Uninstall-Apps -DryRun
# Sync-Repo -Branch "main" -DryRun
