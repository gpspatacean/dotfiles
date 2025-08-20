# Map of AppName to Winget Id
$AppIdMap = @{
    "oh-my-posh" = "JanDeDobbeleer.OhMyPosh"
    "zoxide"     = "ajeetdsouza.zoxide"
    "eza"        = "eza-community.eza"
    "bat"        = "sharkdp.bat"
    "yazi"       = "sxyazi.yazi"
}

function Install-Or-Update-App {
    param(
        [string]$AppName,
        [string]$WingetId,
        [switch]$DryRun
    )
    $appCmd = Get-Command $AppName -ErrorAction SilentlyContinue
    if ($appCmd) {
        Write-Host "$AppName found. Attempting to update..."
        if ($DryRun) {
            Write-Host "[Dry-Run] Would run: winget upgrade --id $WingetId --exact"
        } else {
            winget upgrade --id $WingetId --exact
        }
    } else {
        Write-Host "$AppName not found. Installing..."
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

# Example usage: install or update all apps in the map with dry-run enabled
Check-Apps -DryRun
