# Comprehensive Keybindings Cheatsheet

## Windows Terminal
| Shortcut                         | Action                   | Notes                      |
|----------------------------------|--------------------------|----------------------------|
| Ctrl + Alt + n                   | Next tab                 |                            |
| Ctrl + Alt + p                   | Previous tab             |                            |
| Ctrl + Shift + p                 | Command Palette          |                            |
| Ctrl + Shift + t                 | New tab                  | New tab with profile 1     |
| Ctrl + Shift + w                 | Close current tab        |                            |
| Alt + Shift + -                  | Duplicate pane           | Split down                 |
| Alt + Shift + \                  | Duplicate pane           | Split right                |
| Alt + Left/Right/Up/Down         | Move focus between panes | Maybe delete               |
| Ctrl + Alt + h/j/k/l             | Move focus between panes |                            |
| Alt + Shift + Left/Right/Up/Down | Resize                   | To check against tmux/nvim |
| Ctrl + Shift + Up/Down           | Scroll Up/Down           | To check against tmux/nvim |
| Ctrl + Shift + PgUp/PgDown       | Scroll Up/Down one page  | To check against tmux/nvim |


## tmux
| Shortcut                  | Action                     | Notes                                                                                                                          |
|---------------------------|----------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Prefix (Ctrl+Space)       |                            | Default prefix key                                                                                                             |
| Prefix + c                | New window                 |                                                                                                                                |
| Prefix + n                | Next window                |                                                                                                                                |
| Prefix + p                | Previous window            |                                                                                                                                |
| Prefix + Shift + \        | Split vertical             |                                                                                                                                |
| Prefix + -                | Split horizontal           |                                                                                                                                |
| Ctrl + h/j/k/l            | Move focus between splits  | <ul><li>vim like movement, needs `christoomey/vim-tmux-navigator`</li><li> Keep Ctrl pressed for continuous movement</li></ul> |
| Prefix + (Ctrl + h/j/k/l) | Resize split               | <ul><li>vim like resizing, needs `christoomey/vim-tmux-navigator`</li><li>Left/right not working, to be checked</li></ul>      |
| Prefix + z                | Toggle fullscreen split    |                                                                                                                                |
| Prefix + s                | Show all sessions          | j/k movement; Enter to switch to                                                                                               |
| Prefix + w                | Show all sessions expanded | j/k movement; Enter to switch to                                                                                               |
| Prefix + PgUp             | Enter scroll mode          | <ul><li>PgUp/PgDown/Up/Down movement</li><li> `Alt` + Up/Down movement </li><li> `q` to exit </li></ul>                        |
| Prefix + r                | Reload configuration       |                                                                                                                                |

## Readline (Bash/PowerShell)
| Shortcut          | Action                      | Notes                   |
|-------------------|-----------------------------|-------------------------|
| Alt + j           | Next history                |                         |
| Alt + k           | Previous history            |                         |
| Alt + l           | Accept line (Enter)         |                         |
| Alt + h           | Backspace                   |                         |
| Ctrl + r          | Reverse history search      | Powercharged by fzf     |
| Alt + c           | fzf CD                      | Powercharged by fzf     |
| Ctrl + t          | fzf file/directory search   | Powercharged by fzf     |
| Ctrl + a          | Delete to beginning of line |                         |
| Alt + Ctrl + a    | Delete word before cursor   |                         |
| Ctrl + d          | Delete to end of line       |                         |
| Alt + Ctrl + d    | Delete to end of word       |                         |
| Alt + a           | Go to beginning of line     |                         |
| Alt + d           | Go to end of line           |                         |
| Alt + Ctrl + j    | Backward one character      |                         |
| Alt + Ctrl + h    | Backward one word           |                         |
| Alt + Ctrl + k    | Forward one character       |                         |
| Alt + Ctrl + l    | Forward one word            |                         |
| Ctrl + x Ctrl + e | Open line in editor         | bash only; uses $EDITOR |

## fzf 
| Shortcut   | Action               | Notes |
|------------|----------------------|-------|
| Alt + j/k  | Up/Down selection    |       |
| Ctrl + j/k | Up/Down selection    |       |
| Alt + h/l  | Up/Down preview pane |       |

## Lazygit
| Shortcut    | Action                         | Notes              |
|-------------|--------------------------------|--------------------|
| j/k         | Move up/down item list         |                    |
| h/l         | Move up/down panes             |                    |
| [/]         | Prev/Next tab of the same pane |                    |
| q           | Quit                           |                    |
| PgUp/PgDown | Scroll up/down main window     |                    |
| Ctrl + j/k  | Scroll up/down main window     |                    |
| +           | Next screen mode               |                    |
| ?           | Show keybinds                  | Contextual actions |
| /           | Filter in current pane         |                    |
