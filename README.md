# dockerized-openQA

Provide a docker image of package openQA and openQA-worker


## How to for collaborators

#### webui

1. Build the docker image

```bash
# You may need root privileges or your user should belong to docker group.
docker-build -t openqa-webui:latest github/dockerized-openQA/webui/
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
docker exec -it openqa_webui bash

# then
/var/lib/openqa/script/clone_job.pl --skip-deps --skip-download --host localhost --from https://openqa.opensuse.org 528467
```
