cd runner
if [ -z "$GH_REPOSITORY" ]; then
	echo GH_REPOSITORY not defined
	exit 1
fi
if [ -z "$GH_PAT" ]; then
	echo GH_PAT not defined
	exit 1
fi
. /root/.cargo/env
API_RESPONSE=$(curl -fsX POST -H "Authorization: token ${GH_PAT}" "https://api.github.com/repos/${GH_REPOSITORY}/actions/runners/registration-token")
if [ $? -ne 0 ]; then
	echo "curl failed: ${API_RESPONSE}"
	exit 1
fi

WORKER_TOKEN=$(echo ${API_RESPONSE} | grep -oP 'token":.*?"\K.*?(?=")')
./github-act-runner configure --url https://github.com/$GH_REPOSITORY --token $WORKER_TOKEN --name $(uname -m) --replace --labels $(uname -m)
./github-act-runner run
