FROM openjdk:8-jdk-alpine
MAINTAINER Nilesh Attarde
RUN apk update && apk add bash curl unzip
USER root
ARG USER_HOME=/root

# Maven configuration 
ARG MAVEN_VERSION=3.6.3
ARG MAVEN_URL=https://mirrors.estointernet.in/apache/maven/maven-3/${MAVEN_VERSION}/binaries/
RUN mkdir -p /opt/tools/maven && \
    curl -fsSL -o /tmp/apache-maven.tar.gz ${MAVEN_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xzvf /tmp/apache-maven.tar.gz -C /opt/tools/maven --strip-components=1 && \
    rm -rf /tmp/apache-maven.tar.gz
ENV MAVEN_HOME /opt/tools/maven

# Gradle Configuration
ARG GRADLE_VERSION=6.3
ARG GRADLE_URL=https://services.gradle.org/distributions
RUN curl -fsSL -o /tmp/gradle.zip ${GRADLE_URL}/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip  /tmp/gradle.zip -d /opt/tools/ && \
    rm -rf /tmp/gradle.zip

ENV GRADLE_HOME /opt/tools/gradle-${GRADLE_VERSION}

# Ant Configuration
ARG ANT_VERSION=1.10.7
ARG ANT_URL=http://apachemirror.wuchna.com/ant/binaries
RUN mkdir -p /opt/tools/ant && \
    curl -fsSL -o /tmp/apache-ant.tar.gz ${ANT_URL}/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzvf /tmp/apache-ant.tar.gz -C /opt/tools/ant --strip-components=1 && \
    rm -rf /tmp/apache-ant.tar.gz 

ENV ANT_HOME /opt/tools/ant
ENV PATH "${ANT_HOME}/bin:${GRADLE_HOME}/bin:${MAVEN_HOME}/bin:${PATH}"
