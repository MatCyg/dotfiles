FROM linuxbrew/brew

RUN brew update
RUN brew tap homebrew/cask-fonts
RUN brew tap homebrew/cask
RUN brew install \
  git \
  zsh \
  autojump \
  unzip \
  zip

USER linuxbrew
RUN sudo chsh -s $(which zsh)
RUN rm -rf /home/linuxbrew/.linuxbrew/var/homebrew/locks/*
USER root