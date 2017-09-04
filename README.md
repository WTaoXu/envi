# envi

go/rust/python/gdb/gcc

#change to zsh
chsh -s /bin/zsh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# auto-suggestions
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# autojump
git clone git://github.com/joelthelion/autojump.git
cd autojump
./install.py or ./uninstall.py

echo _prefix_/autojump.sh >> ~/.zshrc

#tmux

