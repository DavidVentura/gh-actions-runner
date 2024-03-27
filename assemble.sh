docker manifest create \
	davidv27/gh-actions:latest \
	--amend davidv27/gh-actions:x86_64-latest \
	--amend davidv27/gh-actions:riscv64-latest \
	--amend davidv27/gh-actions:aarch64-latest

docker manifest push davidv27/gh-actions:latest

docker manifest create \
	davidv27/gh-actions-rs:latest \
	--amend davidv27/gh-actions-rs:x86_64-latest \
	--amend davidv27/gh-actions-rs:riscv64-latest \
	--amend davidv27/gh-actions-rs:aarch64-latest

docker manifest push davidv27/gh-actions-rs:latest
