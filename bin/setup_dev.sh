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

curl -LsSf https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o conda.sh

bash conda.sh -b -p $HOME/miniconda3
rm conda.sh

PATH=$HOME/bin:$HOME/.local/bin:$HOME/miniconda3/bin:/usr/local/bin:$PATH


conda install pandas

conda install numpy

conda install matplotlib

conda install seaborn

conda install -c conda-forge jupyterlab

conda install cx_Oracle

conda install pymysql

