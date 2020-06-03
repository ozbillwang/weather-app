#!/usr/bin/env bash

commit_id=$(git rev-parse --short HEAD)
echo ${commit_id}

docker build -t ozbillwang/weather-app . 
docker tag ozbillwang/weather-app ozbillwang/weather-app:${commit_id}

docker push ozbillwang/weather-app:${commit_id}

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$BRANCH" != "master" ]]; then
  docker push ozbillwang/weather-app
fi

# Generate next incremental tag (Semantic Versioning)
LATEST_TAG=$(git ls-remote --tags origin |awk -F \/ '{print $NF}'|grep ^1.0. |sort -Vr|head -1)
echo ${LATEST_TAG}
if [[ -z "${LATEST_TAG}" ]]
then
    NEXT_TAG="1.0.0"
else
    npm install semver 
    NEXT_TAG=$(semver -c -i patch ${LATEST_TAG})
fi
echo ${NEXT_TAG}

# push the tag
echo "Set Bitbucket Username & Email"
git config user.name "ci"
git config user.email "ci"
echo "Create & Push Bitbucket Tag"
git tag ${NEXT_TAG}
git push origin ${NEXT_TAG}
