FROM ubuntu:18.04

LABEL maintainer="tgremlin82 <tenisonallan@gmail.com>"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV aws=/usr/bin/local/aws

# Install curl
RUN apt-get update \
    && apt-get install -y software-properties-common \
    gnupg \
    curl \ 
    unzip
# Add packer repo
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# Install packer
RUN apt-get update && apt-get install packer -y
# Cleanup
RUN	apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* *.zip
# Install AWS CLI using curl and unzip
RUN mkdir /tmp/aws && cd /tmp/aws \
&& curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&& ./aws/install \
&& cd / \
&& rm -rf /tmp/*
