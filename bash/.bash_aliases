if command -v eza &>/dev/null; then
	unalias ls 2>/dev/null && true
	alias ls="eza -al --classify=always --color=always --icons=always --show-symlinks --follow-symlinks"
fi

if command -v lazygit &>/dev/null; then
	alias lg=lazygit
fi
if command -v fdfind &>/dev/null; then
	alias fd=fdfind
fi
if command -v batcat &>/dev/null; then
	alias cat=batcat
fi

if command -v zoxide &>/dev/null; then
	alias cd=z
fi
