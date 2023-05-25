FROM alpine:latest

RUN apk add --no-cache --update sudo nodejs npm zsh neovim bat curl shadow git

RUN echo 'root:root' | chpasswd

RUN groupadd -g 1000 alpinegroup && \
    useradd -ms /bin/zsh --uid 1000 --gid 1000 alpineuser && \
    echo "alpineuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/10-alpineuser

USER alpineuser
WORKDIR /home/alpineuser

# Install Oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Agrega alias
RUN echo "alias cat=bat" >> /home/alpineuser/.zshrc
RUN echo "alias l='ls -la'" >> /home/alpineuser/.zshrc
RUN echo "alias npm='sudo npm'" >> /home/alpineuser/.zshrc

# RUN git config --global --add safe.directory $HOME/project/*
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="amuse"/' ~/.zshrc



CMD [ "/bin/zsh" ]
