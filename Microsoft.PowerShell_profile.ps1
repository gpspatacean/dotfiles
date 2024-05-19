#Init oh-my-posh; theme should be present
oh-my-posh init pwsh --config "$env:USERPROFILE\.config\customized_atomic.omp.json" | Invoke-Expression

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

Set-Alias -Name gst -Value git-status
Set-Alias -Name glg -Value git-log

Set-Alias -Name lg -Value lazygit
