# See available builds at https://hub.docker.com/r/hseeberger/scala-sbt/tags/
FROM hseeberger/scala-sbt:8u171_2.12.6_1.1.5

ENV _JAVA_OPTIONS="-Xms4G -Xmx4G -Xss4M -XX:MaxMetaspaceSize=512M"

WORKDIR /telemetry-batch-view
