# simple-nodejs-weather-app
Simple Node.js Command Line Weather Application

# run test locally

* Run the web app locally:
```
npm install
node server.js
// Now open your browser and visit: localhost:3000
```

# run in docker locally
```
# if it is exist, and make sure there is no other application taken the port 3000 on host.
docker rm -f weather-app

### start the application in container
docker build -t weather-app . 
docker run -d -p 3000:3000 --name weather-app weather-app 
// Now open your browser and visit: localhost:3000
```
# run with automation way or in CICD

with the script [build.sh](build.sh) you can put to your CICD pipeline tools, such as Jenkins, CircleCI to automation the build

### Prerequest

1. make sure you have set the docker login details problem in CICD environments.
If you don't know, take a reference on local `~/.docker/config.json` if you do push image to hub.docker.com
2. make sure you have set the github token properly, so the build script can push new release tag back to its repository.

### run below build
```
bash ./build.sh
```
this script `build.sh` will build image with tag of git COMMIT ID first, so you can run the test locally with it

```
docker run -d -p 3000:3000 --name weather-app weather-app:<commit_id>
```

If the script detects that's master branch, it will create new release tag with incremental semantic version, such as 1.0.1, 1.0.2, etc.

so you can run your test with 
```
docker run -d -p 3000:3000 --name weather-app weather-app:1.0.2
```

In the future, if the application is published to production, and it doesn't run properly, you can easily rollback 

```
docker run -d -p 3000:3000 --name weather-app weather-app:1.0.1
```

# TODO

Depend on different CICD tools, run the script `build.sh` after new commit is pushed (CI) and add deployment script as follow up (CD)

