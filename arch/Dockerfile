FROM archlinux:latest

RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm \
      sudo \
      bash \
      ca-certificates \
      neovim \
      curl \
      wget \
      zsh \
      git \
      base-devel \
      && \
      rm -rf /var/cache/pacman/*

RUN groupadd -g 1000 archgroup && \
    useradd -ms /bin/bash --uid 1000 --gid 1000 archuser && \
    echo "archuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/10-archuser

USER archuser
WORKDIR /home/archuser

RUN mkdir -p ~/.cargo/bin && \
    wget https://github.com/starship/starship/releases/download/v1.14.2/starship-x86_64-unknown-linux-gnu.tar.gz && \
    tar xvzf starship-x86_64-unknown-linux-gnu.tar.gz && \
    rm starship-x86_64-unknown-linux-gnu.tar.gz && \
    mv starship ~/.cargo/bin/

RUN mkdir -p ~/.config && \
    touch ~/.config/starship.toml && \
    echo 'export PATH=~/.cargo/bin:$PATH' >> ~/.zshrc && \
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc

CMD ["/bin/zsh"]
