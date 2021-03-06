# git_dev

## 记录下 windows 中的 docker 教学

```sh
docker run --name repo alpine/git clone https://github.com/docker/getting-started.git

docker cp repo:/git/getting-started/ .

docker run -d -p 80:80 --name docker-tutorial docker101tutorial

docker tag docker101tutorial duan1v/docker101tutorial

docker push duan1v/docker101tutorial
```


## 生成git镜像，注意最后面的点

```sh
docker build -t duan1v/workspace:git -f Dockerfile .
```

## 克隆公共库

```sh
docker run --rm -v ${pwd}:/git alpine/git clone https://github.com/docker/getting-started.git
```

## 克隆私有库（第一次使用密钥需要交互，所以加上：-it，之后该参数可不加）

```sh
docker run -it --rm -v ${pwd}:/git --mount type=bind,source=${home}/.ssh/id_rsa,target=/root/.ssh/id_rsa,readonly duan1v/workspace:git git clone git@github.com:duan1v/docker_persist.git
```

> 这个要求windows环境中的ssh能连到git，可以在powershell中执行下面命令验证：

```sh
PS G:\Workspace\git> ssh -T git@github.com
Hi duan1v! You've successfully authenticated, but GitHub does not provide shell access.
```



## 运行持久化容器

```sh
docker run -it --name git -v ${pwd}:/git --mount type=bind,source=${home}/.ssh/id_rsa,target=/root/.ssh/id_rsa,readonly duan1v/workspace:git
```