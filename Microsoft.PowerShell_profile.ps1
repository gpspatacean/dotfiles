#Init oh-my-posh; theme should be present
oh-my-posh init pwsh --config "$env:USERPROFILE\.config\customized_atomic.omp.json" | Invoke-Expression

#Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

#Notepad++
Set-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"

#Open a file in a new notepad instance
function nppi_method {
	param([String]$Target)
	#new notepad++ instance; do not open files from other sessions
	npp -multiInst -nosession $Target
}
Set-Alias -Name nppi -Value nppi_method

#Open a directory as a workspace
function nppd_method {
	param([String]$Target)
	#open directory as a workspace; new instance; do not open files from other session
	npp -openFoldersAsWorkspace -multiInst -nosession $Target
}
Set-Alias -Name nppd -Value nppd_method

#Git related stuff
function git-status {
	git status
}

function git-log {
	git lg
}

# Aliases
Set-Alias -Name gst -Value git-status
Set-Alias -Name glg -Value git-log

Set-Alias -Name lg -Value lazygit

function eza-cmd {
	param(
		[Parameter(ValueFromRemainingArguments = $true)]
		[String[]]$PassThruParams
	)

	$command = "eza -alT --classify=always --color=always --icons=always --show-symlinks -L=2 "
	if($PassThruParams) {
		$command += " " + ($PassThruParams -join " ")
	}
	Invoke-Expression $command
}
#Remove-Alias -Name ls
Set-Alias -Name ls -Value eza-cmd -Option AllScope


# Utility Command that tells you where the absolute path of commandlets are
function which ($command) {
 Get-Command -Name $command |
 Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Environment Variables
$env:BAT_CONFIG_PATH="$env:USERPROFILE\.config\bat\config" #`bat` config file path
$env:FZF_CTRL_T_OPTS = "--preview 'if exist {}/ ( eza -alT --classify=always --color=always --icons=always --show-symlinks --git-ignore -L=1 {} ) else ( bat {} )'"
$env:FZF_ALT_C_OPTS="--preview 'eza -alT --classify=always --color=always --icons=always --show-symlinks --git-ignore -L=2 {}'"
