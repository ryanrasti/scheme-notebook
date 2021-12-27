FROM ubuntu:20.04

RUN apt update && apt install -y software-properties-common
RUN add-apt-repository ppa:plt/racket && apt update && DEBIAN_FRONTEND=noninteractive apt install -y racket python3-pip libzmq5
RUN pip install --no-cache-dir notebook
RUN pip install --no-cache-dir jupyterhub

RUN useradd -u 1000 runner && mkdir /home/runner
WORKDIR /home/runner
COPY *.ipynb ./ 
RUN chown -R runner ./
USER runner

RUN echo Y | raco pkg install iracket

COPY racket-simply /usr/bin/
RUN racket-simply
RUN raco iracket install --racket-exe /usr/bin/racket-simply
