#docker build --build-arg SCALA_VERSION=$(sed -n 's/.*scalaVersion[^0-9]*\([0-9.]*\).*/\1/p' build.sbt) --build-arg SBT_VERSION=$(sed -n 's/sbt.version=\([0-9.]*\)/\1/p' project/build.properties)  -t telemetry-batch-view .

# See available builds at https://hub.docker.com/r/hseeberger/scala-sbt/tags/
FROM openjdk:8

ARG SCALA_VERSION
ARG SBT_VERSION

###################################################
## Install Scala and sbt
## See https://github.com/hseeberger/scala-sbt

# Scala expects this file
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

###################################################
## Install Scala and sbt

ENV _JAVA_OPTIONS="-Xms4G -Xmx4G -Xss4M -XX:MaxMetaspaceSize=512M"

WORKDIR /telemetry-batch-view
