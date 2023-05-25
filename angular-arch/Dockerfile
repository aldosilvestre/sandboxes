FROM archlinux:latest

RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm \
      sudo \
      bash \
      ca-certificates \
      neovim \
      npm \
      lsd \
      bat \
      curl \
      wget \
      git \
      base-devel \
      zsh \
      && \
      rm -rf /var/cache/pacman/*

RUN groupadd -g 1000 archgroup && \
    useradd -ms /bin/bash --uid 1000 --gid 1000 archuser && \
    echo "archuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/10-archuser

USER archuser
WORKDIR /home/archuser

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Agrega alias
RUN echo "alias ls=lsd" >> /home/archuser/.zshrc
RUN echo "alias cat=bat" >> /home/archuser/.zshrc
RUN echo "alias l='ls -la'" >> /home/archuser/.zshrc
RUN echo "alias npm='sudo npm'" >> /home/archuser/.zshrc

RUN git config --global --add safe.directory $HOME/project/*
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="amuse"/' ~/.zshrc

# Instalo angular
RUN sudo npm install -g @angular/cli

CMD ["/bin/zsh"]
