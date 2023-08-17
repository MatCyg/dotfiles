To build docker image:
```shell
docker build -t "setup-test" -f ./setup/Dockerfile .
```

To run docker:
```shell
docker run -it -v $DOTFILES/:/root/Projects/personal/dotfiles/ setup-test zsh
```

Execute the following command inside docker container:
```shell
bash -c /root/Projects/personal/dotfiles/setup/setup.sh
```