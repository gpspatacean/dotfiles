oh-my-posh init pwsh --config "$env:USERPROFILE\.config\customized_atomic.omp.json" | Invoke-Expression

New-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"

function git-status {
	git status
}

function git-log {
	git lg
}

New-Alias -Name gst -Value git-status
New-Alias -Name glg -Value git-log
