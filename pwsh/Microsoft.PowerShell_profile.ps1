#Init oh-my-posh; theme should be present
if (Get-Command "oh-my-posh.exe" -ErrorAction SilentlyContinue)
{
	if (Test-Path "$env:USERPROFILE\.config\customized_atomic.omp.json")
	{
		oh-my-posh init pwsh --config "$env:USERPROFILE\.config\customized_atomic.omp.json" | Invoke-Expression
	}
	else
	{
		Write-Host "oh-my-posh custom theme not found, using default theme."
		oh-my-posh init pwsh | Invoke-Expression
	}
}
else
{
	Write-Host "oh-my-posh not installed."
}

#Init zoxide if installed
if (Get-Command "zoxide.exe" -ErrorAction SilentlyContinue)
{
	Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
}
else
{
	Write-Host "Zoxide is not installed."
}

#Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

#Notepad++
if (Test-Path "C:\Program Files\Notepad++\notepad++.exe") {
    Set-Alias -Name npp -Value "C:\Program Files\Notepad++\notepad++.exe"
} elseif (Test-Path "C:\Program Files (x86)\Notepad++\notepad++.exe") {
    Set-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"
}

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

# Unix `touch` command
function touch {
	param(
		[Parameter(ValueFromRemainingArguments = $true)]
		[String[]]$PassThruParams
	)
	foreach ($FileName in $PassThruParams) {
		if (-not (Test-Path $FileName)) {
			New-Item -Path $FileName -ItemType File
		} else {
			(Get-Item $FileName).LastWriteTime = Get-Date
		}
	}
}

# Environment Variables
$env:XDG_CONFIG_HOME="$env:USERPROFILE\.config"
$env:BAT_CONFIG_PATH="$env:XDG_CONFIG_HOME\bat\config" #`bat` config file path
$env:RIPGREP_CONFIG_PATH="$env:XDG_CONFIG_HOME\rg\config" #'rg' config file path
$env:YAZI_CONFIG_HOME="$env:XDG_CONFIG_HOME\yazi" # `yazi` config home
$env:FZF_DEFAULT_OPTS="--bind=alt-j:down,alt-k:up,alt-h:preview-down,alt-l:preview-up"
$env:FZF_CTRL_T_OPTS="--preview 'if exist {}/ ( eza -al --classify=always --color=always --icons=always --show-symlinks --follow-symlinks --git-ignore {} ) else ( bat {} )'"
$env:FZF_ALT_C_OPTS="--preview 'eza -alT --classify=always --color=always --icons=always --show-symlinks --follow-symlinks --git-ignore -L=2 {}'"

#Re-maps for readline to be used in powershell
#Strive to be identical between powershell and bash

Set-PSReadLineKeyHandler -chord Alt+j -function NextHistory # Next item in history
Set-PSReadLineKeyHandler -chord Alt+k -function PreviousHistory # Previous item in history
Set-PSReadLineKeyHandler -chord Alt+l -function AcceptLine # Enter
Set-PSReadLineKeyHandler -chord Alt+h -function BackwardDeleteChar # Delete the character before the cursor, BACKSPACE

Set-PSReadLineKeyHandler -chord Ctrl+a -function BackwardDeleteLine # Delete everything from the cursor to the beginning of line
Set-PSReadLineKeyHandler -chord Alt+Ctrl+a -function BackwardDeleteWord # Delete everything from the cursor to the beginning of word
Set-PSReadLineKeyHandler -chord Ctrl+d -function ForwardDeleteLine # Delete everything from the cursor to the end of line
Set-PSReadLineKeyHandler -chord Alt+Ctrl+d -function DeleteWord # Delete everything from the current cursor to the end of word

Set-PSReadLineKeyHandler -chord Alt+a -function BeginningOfLine # Go to the beginning of line
Set-PSReadLineKeyHandler -chord Alt+d -function EndOfLine # Go to the end of line

Set-PSReadLineKeyHandler -chord Alt+Ctrl+j -function BackwardChar # Go backward one character
Set-PSReadLineKeyHandler -chord Alt+Ctrl+h -function BackwardWord # Go to the beginning of the current word, or the previous word
Set-PSReadLineKeyHandler -chord Alt+Ctrl+k -function ForwardChar # Go Forward one character
Set-PSReadLineKeyHandler -chord Alt+Ctrl+l -function ForwardWord # Go to the end of the current word, or the next word

#Other setups
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -BellStyle None
