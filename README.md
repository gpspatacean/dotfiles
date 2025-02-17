## Personal dotfiles

### Vim
Install plugin manager: ```git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim```
Run ```:PluginInstall``` in vim

### Tmux
Install plugin manager: ```git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm```
Press ```Prefix + I``` to install

### fzf

### eza
https://github.com/eza-community/eza

```bash
wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
sudo chmod +x eza
sudo chown root:root eza
sudo mv eza /usr/local/bin/eza
```
`winget install eza-community.eza`

### bat
https://github.com/sharkdp/bat

`sudo apt install bat`

`winget install sharkdp.bat `
