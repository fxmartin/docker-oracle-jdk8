# docker-oracle-jdk8
Dockerfile project for building a container with oracle jdk 8 instead of Open jdk. This image is based on [fxmartin/docker-sshd-nginx](https://github.com/fxmartin/docker-sshd-nginx).

## About

This repository contains all needed resources to build a docker image with following features:
* Oracle JDK 8
* nginx running and serving simple static page (inherited from base image);
* sshd with passwordless login (inherited from base image);
* services configured and running via supervisord  (inherited from base image).

For convenience there is a *./manage.sh* command for building, starting (with proper port mappings), stopping and connecting via ssh.

## Usage

You can download [this image](https://hub.docker.com/r/fxmartin/docker-oracle-jdk8/) from public [Docker Registry](https://hub.docker.com/).
A bash script is provided: manage.sh, which allows to manage the container, considering that it won't stop by itself due to supervisor daemon:
* start: to start the container
* stop: to stop the container
* build: build the docker image
* ssh: ssh to the container
* web: launch chrome on port 80 from nginx, with the IP automatically retrieved from the script
* version: display java version

**Run using command:**
```
docker run -d -p 55522:22 -p 55580:80 fxmartin/docker-oracle-jdk8
or
manage.sh start
```

**Connect via ssh:**
```
manage.sh ssh
```
## Screenshots

Image 1 - nginx welcome page

![nginx welcome page](https://raw.github.com/fxmartin/docker-oracle-jdk8/master/screenshots/nginx_welcome_page.png)

## Notes
Just don't forget to add private key (yeah, I know) from **ssh_keys** folder to you '~/.ssh/' and add it via
```
ssh-add -K ~/.ssh/id_rsa_docker
```