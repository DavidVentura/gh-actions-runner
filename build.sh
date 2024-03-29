docker build -t davidv27/gh-actions:$(uname -m)-latest -f Dockerfile .
docker build --build-arg ARCH=$(uname -m) -t davidv27/gh-actions-rs:$(uname -m)-latest -f Dockerfile-rs .
