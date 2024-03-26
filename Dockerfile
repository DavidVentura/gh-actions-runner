FROM debian:rc-buggy-20240311
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --profile minimal --default-toolchain stable

RUN export ARCH=$(uname -m | sed 's/aarch64/arm64/') && echo $ARCH && \
	mkdir runner && cd runner && \
	curl -s -L https://github.com/ChristopherHX/github-act-runner/releases/download/v0.6.8/binary-linux-$ARCH.tar.gz | tar xz

ENV RUNNER_ALLOW_RUNASROOT=1
RUN apt-get install -y nodejs build-essential make gcc
COPY start-runner.sh /
CMD ["/bin/sh", "/start-runner.sh"]
