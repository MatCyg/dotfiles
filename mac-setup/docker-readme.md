To build docker image:
```shell
docker build -t "mac-setup-test" -f ./mac-setup/Dockerfile .
```

To run docker:
```shell
docker run -it -v $DOTFILES/:/root/Projects/personal/dotfiles/ mac-setup-test zsh
```

Execute the following command inside docker container:
```shell
bash -c /root/Projects/personal/dotfiles/mac-setup/mac-setup.sh
```