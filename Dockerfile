FROM ubuntu:20.04

RUN apt-get update --fix-missing
RUN apt-get install -y git vim

# Create user and set working directory
RUN useradd --create-home --shell /bin/bash term_user
USER term_user
WORKDIR /home/term_user

RUN git clone https://github.com/gchan510/terminal_configs
