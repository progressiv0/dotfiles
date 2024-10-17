sudo apt update && sudo apt upgrade -y
sudo apt install git neovim zsh btop python3 python3-pip -y
sudo apt install procps dnsutils lm-sensors -y
pip3 install archey4
cd ~
mkdir Downloads

python -m venv python-env
cd python-env/bin/
./pip3 install archey4

git pull --recurse-submodules git@github.com:progressiv0/.dotfiles.git
cd ~/.dotfiles/
./scripts/zsh_install.sh
./scripts/vim_install.sh
cd ~/
