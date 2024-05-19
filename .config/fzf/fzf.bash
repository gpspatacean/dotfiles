# Setup fzf
# ---------
if [[ ! "$PATH" == */home/spaty/.local/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/spaty/.local/.fzf/bin"
fi

eval "$(fzf --bash)"
