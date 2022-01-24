# syntax=docker/dockerfile:1
FROM kalilinux/kali-rolling
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install kali-linux-headless
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install neovim nodejs gdb python3.9-venv python3-pip man-db
RUN useradd -m user1 && chsh -s /usr/bin/zsh user1
WORKDIR /home/user1
COPY home/ ./
RUN chown user1:user1 -R /home/user1 && passwd -d user1 && echo 'user1 ALL=(ALL:ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo
USER user1
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN nvim --headless +PlugInstall +qall
RUN pip install --no-warn-script-location pwntools ropper keystone-engine capstone unicorn pycryptodome
ENTRYPOINT ["/usr/bin/zsh"]
