cd runner
if [ -z "$GH_REPOSITORY" ]; then
	echo GH_REPOSITORY not defined
	exit 1
fi
if [ -z "$GH_TOKEN" ]; then
	echo GH_TOKEN not defined
	exit 1
fi
. /root/.cargo/env
./github-act-runner configure --url $GH_REPOSITORY --token $GH_TOKEN --name $(uname -m) --replace --labels $(uname -m)
./github-act-runner run
