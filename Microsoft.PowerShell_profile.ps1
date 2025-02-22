#Init oh-my-posh; theme should be present
oh-my-posh init pwsh --config "$env:USERPROFILE\.config\customized_atomic.omp.json" | Invoke-Expression

#Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

#Notepad++
Set-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"

#Open a file in a new notepad instance
function nppi_method {
	[alias('nppi')]
	param([String]$Target)
	#new notepad++ instance; do not open files from other sessions
	npp -multiInst -nosession $Target
}

#Open a directory as a workspace
function nppd_method {
	[alias('nppd')]
	param([String]$Target)
	#open directory as a workspace; new instance; do not open files from other session
	npp -openFoldersAsWorkspace -multiInst -nosession $Target
}

#Git related stuff
function git-status {
	[alias('gst')]
	param()
	git status
}

function git-log {
	[alias('glg')]
	param()
	git lg
}

# Aliases
Set-Alias -Name lg -Value lazygit

function eza-cmd {
	[alias('ls')]
	param(
		[Parameter(ValueFromRemainingArguments = $true)]
		[String[]]$PassThruParams
	)

	$command = "eza -al --classify=always --color=always --icons=always --show-symlinks --follow-symlinks "
	if($PassThruParams) {
		$command += " " + ($PassThruParams -join " ")
	}
	Invoke-Expression $command
}

# Utility Command that tells you where the absolute path of commandlets are
function which ($command) {
 Get-Command -Name $command |
 Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Environment Variables
$env:XDG_CONFIG_HOME="$env:USERPROFILE\.config"
$env:BAT_CONFIG_PATH="$env:XDG_CONFIG_HOME\bat\config" #`bat` config file path
$env:FZF_CTRL_T_OPTS = "--preview 'if exist {}/ ( eza -al --classify=always --color=always --icons=always --show-symlinks --git-ignore --follow-symlinks {} ) else ( bat {} )'"
$env:FZF_ALT_C_OPTS="--preview 'eza -alT --classify=always --color=always --icons=always --show-symlinks --git-ignore --follow-symlinks -L=2 {}'"
