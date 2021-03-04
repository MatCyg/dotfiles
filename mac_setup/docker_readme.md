To build docker image:
```shell
docker build -t "mac_setup_test" -f ./mac_setup/Dockerfile .
```

To run docker:
```shell
docker run -it -v $DOTFILES/:/root/Projects/personal/dotfiles/ mac_setup_test zsh
```

Execute the following command inside docker container:
```shell
bash -c /root/Projects/personal/dotfiles/mac_setup/mac_setup.sh
```