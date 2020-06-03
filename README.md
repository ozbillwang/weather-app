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

# start the application in container
docker build -t weather-app . 
docker run -d -p 3000:3000 -n weather-app weather-app 
// Now open your browser and visit: localhost:3000
```
# run in CICD

with the script [build.sh](build.sh) you can put to your CICD pipeline tools, such as Jenkins, CircleCI to automation the build

### Prerequest

1. make sure you have set the docker login details problem in CICD environments.
If you don't know, take a reference on local `~/.docker/config.json` if you do push image to hub.docker.com

2. run below build


