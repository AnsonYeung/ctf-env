# syntax=docker/dockerfile:1
FROM kalilinux/kali-rolling
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install kali-linux-headless
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install neovim nodejs gdb python3.9-venv python3-pip man-db
RUN useradd -m user1 && chsh -s /usr/bin/zsh user1
WORKDIR /home/user1
COPY home/ ./
RUN chown user1:user1 -R /home/user1 && passwd -d user1 && echo 'user1 ALL=(ALL:ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo
USER user1
RUN nvim +PlugInstall +qall
RUN pip install pwntools ropper keystone-engine capstone unicorn pycryptodome
ENTRYPOINT ["/usr/bin/zsh"]
