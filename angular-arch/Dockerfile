FROM archlinux:latest

# Actualiza el sistema base y instala las herramientas necesarias
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm \
      sudo \
      bash \
      ca-certificates \
      neovim \
      curl \
      wget \
      git \
      base-devel \
      npm \
      && \
      rm -rf /var/cache/pacman/*

RUN groupadd -g 1000 archgroup && \
    useradd -ms /bin/bash --uid 1000 --gid 1000 archuser && \
    echo "archuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/10-archuser

# Agrega alias
RUN echo "alias l='ls -la'" >> /home/archuser/.bashrc
RUN echo "alias npm='sudo npm'" >> /home/archuser/.bashrc
RUN echo "alias pnpm='sudo pnpm'" >> /home/archuser/.bashrc

USER archuser
WORKDIR /home/archuser

# Crea carpeta compartida para el proyecto
RUN mkdir project

# Instalo angular
RUN sudo npm install -g @angular/cli

# Expone el puerto
EXPOSE 4200

# Comando de inicio del contenedor
CMD ["bash"]
