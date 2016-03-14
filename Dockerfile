##############################################################################
# Dockerfile project for building a mix container with oracle jdk 8.
# Source image https://github.com/fxmartin/docker-sshd-nginx
# provides nginx and sshd as well.
#
# Build with docker build -t fxmartin/docker-oracle-jdk8 .
#
# Syncordis Copyright 2016
# Author: FX
# Date: 14-mar-2016
# Version: 1.0.0
##############################################################################

FROM fxmartin/docker-sshd-nginx

# Maintainer details
MAINTAINER fxmartin <fxmartin@syncordisconsulting.com>

# Install Oracle JDK v8 instead of OpenJDK:
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y --no-install-recommends \
        openssh-server \
        oracle-java8-installer \
        unzip  && \
   apt-get autoremove && apt-get autoclean && apt-get clean -y

# Set the JAVA_HOME environment variable
ENV JAVA_HOME  /usr/lib/jvm/java-8-oracle

# update nginx
ADD nginx/index.html        /var/www/index.html

#tcp, nginx, sshd
EXPOSE 80 22

CMD ["/usr/bin/supervisord", "-n"]