# syntax=docker/dockerfile:1
FROM kalilinux/kali-rolling
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install kali-linux-headless
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install neovim nodejs gdb python3.9-venv python3-pip man-db python3-pycryptodome python3-capstone clangd-12 npm
RUN npm install -g pyright
RUN useradd -m user1 && chsh -s /usr/bin/zsh user1
# ensure all permission correct first
COPY home/ /home/user1/github/dotfiles/
WORKDIR /home/user1/github/dotfiles
RUN chown user1:user1 -R /home/user1 && passwd -d user1 && echo 'user1 ALL=(ALL:ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo
# then switch to user
USER user1
RUN ./setup.sh -s -f
RUN nvim --headless +PlugInstall +qall
RUN nvim --headless +qall
RUN pip install --no-warn-script-location pwntools ropper keystone-engine unicorn
WORKDIR /home/user1
ENTRYPOINT ["/usr/bin/zsh"]
