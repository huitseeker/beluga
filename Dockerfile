FROM ubuntu:20.04

LABEL "com.github.actions.name"="beluga"
LABEL "com.github.actions.description"="Ubuntu with python, lapack, clang"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="http://github.com/huitseeker/beluga"
LABEL "homepage"="http://github.com/huitseeker/beluga"
LABEL "maintainer"="Francois Garillot <francois@garillot.net>"

# Add clang & others
RUN apt-get update && apt-get install -y --no-install-recommends git tmux\
  xz-utils curl python3-pip python3-dev python3-numpy libatlas-base-dev\
  build-essential \
  && apt-get install -y clang-11\
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh

# Get some specific python packages
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Get Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
