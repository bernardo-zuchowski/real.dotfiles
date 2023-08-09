#!/bin/sh

# install first the i3, i3status, zsh, tmux, nvim, kitty

# i3 symlink
cp -rs /home/$USER/personal/real.dotfiles/i3 /home/$USER/.config/i3
# i3status symlinks
cp -rs /home/$USER/personal/real.dotfiles/i3status /home/$USER/.config/i3status
# tmux-sessionizer symlink
ln -s /home/$USER/personal/real.dotfiles/.local/bin/tmux-sessionizer /home/$USER/.local/bin/tmux-sessionizer
# zsh symlink
ln -s /home/$USER/personal/real.dotfiles/.zshrc /home/$USER/.zshrc
# tmux symlinks
ln -s /home/$USER/personal/real.dotfiles/.tmux.conf /home/$USER/.tmux.conf
cp -rs /home/$USER/personal/real.dotfiles/.tmux /home/$USER/.tmux
# nvim symlinks
cp -rs /home/$USER/personal/real.dotfiles/nvim /home/$USER/.config/nvim
# kitty symlinks
cp -rs /home/$USER/personal/real.dotfiles/kitty /home/$USER/.config/kitty
