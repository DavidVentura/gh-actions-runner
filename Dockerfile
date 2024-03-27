FROM debian:rc-buggy-20240311
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates
RUN export ARCH=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/amd64/') && echo $ARCH && \
	mkdir runner && cd runner && \
	curl -s -L https://github.com/ChristopherHX/github-act-runner/releases/download/v0.6.8/binary-linux-$ARCH.tar.gz | tar xz

ENV RUNNER_ALLOW_RUNASROOT=1
COPY start-runner.sh /
ENTRYPOINT ["/bin/sh", "/start-runner.sh"]
