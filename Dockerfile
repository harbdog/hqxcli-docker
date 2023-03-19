FROM maven:3.6.3-jdk-8 as builder

WORKDIR /usr/src/hqxcli-java
COPY . .

RUN mvn clean install
RUN mkdir /dist && mv ./target/hqx-java-*-jar-with-dependencies.jar /dist/hqx-java.jar


FROM openjdk:8-slim-bullseye

COPY --from=builder /dist /

WORKDIR /pwd
ENTRYPOINT [ "java", "-jar", "/hqx-java.jar" ]
