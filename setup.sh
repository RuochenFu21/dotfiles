/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/RuochenFu21/dotfiles.git ~/.config  

cd ~/.config

brew bundle

ln ~/.config/zsh/.zshrc ~/.zshrc

defaults write com.apple.dock expose-group-apps -bool true && killall Dock
