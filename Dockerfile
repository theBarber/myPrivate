FROM maven:3.6.2-jdk-8

ARG ENVIRONMENT
ENV ENVIRONMENT=$ENVIRONMENT

ARG SUITE_NAME
ENV SUITE_NAME=$SUITE_NAME

ARG TAGS_TO_RUN
ENV TAGS_TO_RUN=$TAGS_TO_RUN

ADD . /ramp-lift-automation
WORKDIR /ramp-lift-automation


RUN mvn clean install test -Dcucumber.options="--tags $TAGS_TO_RUN" -P $ENVIRONMENT; exit 0