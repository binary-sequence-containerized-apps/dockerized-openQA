# dockerized-openQA


## Expectations

1. As a user, I want to start the containers without needing docker volumes, or any external data, so I can test the docker images as they are.*
2. As a user, I want to run the webui container and the worker container on different machines without needing docker volumes, or any external data, so I can test the docker images as they are.*
3. As a user, I want that the containers provide hints for text files configuration, to allow me know which parameters are available to configure the services inside the container.
4. As a user, I want to be able to use volumes to keep important data outside the container on productive instances.

* For 1 and 2, the parameter --link is not considered external data, even when an external ip address is provided.

## How to for collaborators

#### webui

1. Build the docker image

```bash
# You may need root privileges or your user should belong to docker group.
docker build -t openqa-webui:latest github/dockerized-openQA/webui/
```

2. Start the webui

```bash
# You may need root privileges or your user should belong to docker group.
docker run --rm -it --name openqa_webui -p 80:80 -p 873:873 openqa-webui:latest bash

# then
/root/run_openqa.sh
```

3. Clone a job

```bash
# You may need root privileges or your user should belong to docker group.
docker exec -it --user geekotest openqa_webui bash

# then
/var/lib/openqa/script/clone_job.pl --skip-deps --skip-download --host localhost --from https://openqa.opensuse.org 532602
```

#### worker

1. Build the docker image

```bash
# You may need root privileges or your user should belong to docker group.
docker build -t openqa-worker-x86_64:latest github/dockerized-openQA/worker-x86_64/
```

2. Start the worker on the same host as the webui

* **Important:** be sure that you logged in on the webui using your web browser before starting the worker. After the first login, the credentials will be created. If you started the worker first, the worker will not be able to connect to the webui even after login, then stop the container and start it again.

```bash
# You may need root privileges or your user should belong to docker group.
docker run --privileged --rm -it --name openqa_worker --link openqa_webui:openqa-webui openqa-worker-x86_64:latest bash

# then
/usr/share/openqa/script/worker --verbose --instance 1
```
