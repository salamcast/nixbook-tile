# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install zsh theme powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

# install zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh-syntax-highlighting


# copy zshrc and p10k.zsh to HOME directory
cp /etc/nixbook-tile/config/zshrc ~/.zshrc

cp /etc/nixbook-tile/config/p10k.zsh ~/.p10k.zsh


# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh



