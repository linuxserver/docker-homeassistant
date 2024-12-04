<!-- DO NOT EDIT THIS FILE MANUALLY -->
<!-- Please read https://github.com/linuxserver/docker-homeassistant/blob/main/.github/CONTRIBUTING.md -->
[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

[![Blog](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=Blog)](https://blog.linuxserver.io "all the things you can do with our containers including How-To guides, opinions and much more!")
[![Discord](https://img.shields.io/discord/354974912613449730.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Discord&logo=discord)](https://discord.gg/YWrKVTn "realtime support / chat with the community and the team.")
[![Discourse](https://img.shields.io/discourse/https/discourse.linuxserver.io/topics.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=discourse)](https://discourse.linuxserver.io "post on our community forum.")
[![Fleet](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=Fleet)](https://fleet.linuxserver.io "an online web interface which displays all of our maintained images.")
[![GitHub](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=GitHub&logo=github)](https://github.com/linuxserver "view the source for all of our repositories.")
[![Open Collective](https://img.shields.io/opencollective/all/linuxserver.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Supporters&logo=open%20collective)](https://opencollective.com/linuxserver "please consider helping us by either donating or contributing to our budget")

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring:

* regular and timely application updates
* easy user mappings (PGID, PUID)
* custom base image with s6 overlay
* weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
* regular security updates

Find us at:

* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [Discourse](https://discourse.linuxserver.io) - post on our community forum.
* [Fleet](https://fleet.linuxserver.io) - an online web interface which displays all of our maintained images.
* [GitHub](https://github.com/linuxserver) - view the source for all of our repositories.
* [Open Collective](https://opencollective.com/linuxserver) - please consider helping us by either donating or contributing to our budget

# [linuxserver/homeassistant](https://github.com/linuxserver/docker-homeassistant)

[![Scarf.io pulls](https://scarf.sh/installs-badge/linuxserver-ci/linuxserver%2Fhomeassistant?color=94398d&label-color=555555&logo-color=ffffff&style=for-the-badge&package-type=docker)](https://scarf.sh)
[![GitHub Stars](https://img.shields.io/github/stars/linuxserver/docker-homeassistant.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/linuxserver/docker-homeassistant)
[![GitHub Release](https://img.shields.io/github/release/linuxserver/docker-homeassistant.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/linuxserver/docker-homeassistant/releases)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=GitHub%20Package&logo=github)](https://github.com/linuxserver/docker-homeassistant/packages)
[![GitLab Container Registry](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=GitLab%20Registry&logo=gitlab)](https://gitlab.com/linuxserver.io/docker-homeassistant/container_registry)
[![Quay.io](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=Quay.io)](https://quay.io/repository/linuxserver.io/homeassistant)
[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/homeassistant.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/linuxserver/homeassistant)
[![Docker Stars](https://img.shields.io/docker/stars/linuxserver/homeassistant.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/linuxserver/homeassistant)
[![Jenkins Build](https://img.shields.io/jenkins/build?labelColor=555555&logoColor=ffffff&style=for-the-badge&jobUrl=https%3A%2F%2Fci.linuxserver.io%2Fjob%2FDocker-Pipeline-Builders%2Fjob%2Fdocker-homeassistant%2Fjob%2Fmain%2F&logo=jenkins)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-homeassistant/job/main/)
[![LSIO CI](https://img.shields.io/badge/dynamic/yaml?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=CI&query=CI&url=https%3A%2F%2Fci-tests.linuxserver.io%2Flinuxserver%2Fhomeassistant%2Flatest%2Fci-status.yml)](https://ci-tests.linuxserver.io/linuxserver/homeassistant/latest/index.html)

[Home Assistant Core](https://www.home-assistant.io/) - Open source home automation that puts local control and privacy first. Powered by a worldwide community of tinkerers and DIY enthusiasts. Perfect to run on a Raspberry Pi or a local server.

[![homeassistant](https://github.com/home-assistant/home-assistant.io/raw/next/source/images/favicon-192x192-full.png)](https://www.home-assistant.io/)

## Supported Architectures

We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://distribution.github.io/distribution/spec/manifest-v2-2/#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `lscr.io/linuxserver/homeassistant:latest` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | amd64-\<version tag\> |
| arm64 | ✅ | arm64v8-\<version tag\> |
| armhf | ❌ | |

## Application Setup

This image is based on Home Assistant Core.

The Webui can be found at `http://your-ip:8123`. Follow the wizard to set up Home Assistant.

### Host vs. Bridge

Home Assistant can [discover][hb0] and automatically configure
[zeroconf][hb1]/[mDNS][hb2] and [UPnP][hb3] devices on your network. In
order for this to work you must create the container with `--net=host`.

[hb0]: https://www.home-assistant.io/integrations/discovery/#mdns-and-upnp
[hb1]: https://en.wikipedia.org/wiki/Zero-configuration_networking
[hb2]: https://en.wikipedia.org/wiki/Multicast_DNS
[hb3]: https://en.wikipedia.org/wiki/Universal_Plug_and_Play

### Accessing Bluetooth Device

In order to provide HA with access to the host's Bluetooth device, one needs to install BlueZ on the host, add the capabilities `NET_ADMIN` and `NET_RAW` to the container, and map dbus as a volume as shown in the below examples.

#### Docker Cli:
```bash
--cap-add=NET_ADMIN --cap-add=NET_RAW -v /var/run/dbus:/var/run/dbus:ro
```

#### Docker Compose:
```yaml
    cap_add:
      - NET_ADMIN
      - NET_RAW
    volumes:
      - /var/run/dbus:/var/run/dbus:ro
```

### Using the Ping integration

For the [Ping][ping0] integration to work, the capability `NET_RAW` must be added to the container. See above for instructions.

[ping0]: https://www.home-assistant.io/integrations/ping

## Usage

To help you get started creating a container from this image you can either use docker-compose or the docker cli.

>[!NOTE]
>Unless a parameter is flaged as 'optional', it is *mandatory* and a value must be provided.

### docker-compose (recommended, [click here for more info](https://docs.linuxserver.io/general/docker-compose))

```yaml
---
services:
  homeassistant:
    image: lscr.io/linuxserver/homeassistant:latest
    container_name: homeassistant
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
    volumes:
      - /path/to/data:/config
    ports:
      - 8123:8123 #optional
    devices:
      - /path/to/device:/path/to/device #optional
    restart: unless-stopped
```

### docker cli ([click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=homeassistant \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 8123:8123 `#optional` \
  -v /path/to/data:/config \
  --device /path/to/device:/path/to/device `#optional` \
  --restart unless-stopped \
  lscr.io/linuxserver/homeassistant:latest
```

## Parameters

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `--net=host` | Shares host networking with container. Required for some devices to be discovered by Home Assistant. |
| `-p 8123` | Application WebUI, only use this if you are not using host mode. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Etc/UTC` | specify a timezone to use, see this [list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). |
| `-v /config` | Home Assistant config storage path. |
| `--device /path/to/device` | For passing through USB, serial or gpio devices. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```bash
-e FILE__MYVAR=/run/secrets/mysecretvariable
```

Will set the environment variable `MYVAR` based on the contents of the `/run/secrets/mysecretvariable` file.

## Umask for running applications

For all of our images we provide the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add. Please read up [here](https://en.wikipedia.org/wiki/Umask) before asking for support.

## User / Group Identifiers

When using volumes (`-v` flags), permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id your_user` as below:

```bash
id your_user
```

Example output:

```text
uid=1000(your_user) gid=1000(your_user) groups=1000(your_user)
```

## Docker Mods

[![Docker Mods](https://img.shields.io/badge/dynamic/yaml?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=homeassistant&query=%24.mods%5B%27homeassistant%27%5D.mod_count&url=https%3A%2F%2Fraw.githubusercontent.com%2Flinuxserver%2Fdocker-mods%2Fmaster%2Fmod-list.yml)](https://mods.linuxserver.io/?mod=homeassistant "view available mods for this container.") [![Docker Universal Mods](https://img.shields.io/badge/dynamic/yaml?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=universal&query=%24.mods%5B%27universal%27%5D.mod_count&url=https%3A%2F%2Fraw.githubusercontent.com%2Flinuxserver%2Fdocker-mods%2Fmaster%2Fmod-list.yml)](https://mods.linuxserver.io/?mod=universal "view available universal mods.")

We publish various [Docker Mods](https://github.com/linuxserver/docker-mods) to enable additional functionality within the containers. The list of Mods available for this image (if any) as well as universal mods that can be applied to any one of our images can be accessed via the dynamic badges above.

## Support Info

* Shell access whilst the container is running:

    ```bash
    docker exec -it homeassistant /bin/bash
    ```

* To monitor the logs of the container in realtime:

    ```bash
    docker logs -f homeassistant
    ```

* Container version number:

    ```bash
    docker inspect -f '{{ index .Config.Labels "build_version" }}' homeassistant
    ```

* Image version number:

    ```bash
    docker inspect -f '{{ index .Config.Labels "build_version" }}' lscr.io/linuxserver/homeassistant:latest
    ```

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (noted in the relevant readme.md), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Compose

* Update images:
    * All images:

        ```bash
        docker-compose pull
        ```

    * Single image:

        ```bash
        docker-compose pull homeassistant
        ```

* Update containers:
    * All containers:

        ```bash
        docker-compose up -d
        ```

    * Single container:

        ```bash
        docker-compose up -d homeassistant
        ```

* You can also remove the old dangling images:

    ```bash
    docker image prune
    ```

### Via Docker Run

* Update the image:

    ```bash
    docker pull lscr.io/linuxserver/homeassistant:latest
    ```

* Stop the running container:

    ```bash
    docker stop homeassistant
    ```

* Delete the container:

    ```bash
    docker rm homeassistant
    ```

* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images:

    ```bash
    docker image prune
    ```

### Image Update Notifications - Diun (Docker Image Update Notifier)

>[!TIP]
>We recommend [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended or supported.

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:

```bash
git clone https://github.com/linuxserver/docker-homeassistant.git
cd docker-homeassistant
docker build \
  --no-cache \
  --pull \
  -t lscr.io/linuxserver/homeassistant:latest .
```

The ARM variants can be built on x86_64 hardware and vice versa using `lscr.io/linuxserver/qemu-static`

```bash
docker run --rm --privileged lscr.io/linuxserver/qemu-static --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **07.11.24:** - Add go2rtc binary.
* **12.10.24:** - Allow uv to modify system python packages.
* **07.10.24:** - Switch to `uv` instead of `pip`.
* **03.07.24:** - Rebase to alpine 3.20.
* **05.03.24:** - Add mime.types to help with detection of certain media files.
* **13.02.24:** - Rebase to alpine 3.19, upgrade to python 3.12. Restructure python packages so all packages are internal (no more venv in /config). Use upstream project's wheels. Due to an upstream issue, on first start of the newly updated container, some custom integrations may be disabled in HA due to missing dependencies. A subsequent container restart should fix that and the integrations should be re-enabled.
* **18.12.23:** - Add Bluetooth instructions to readme.
* **05.07.23:** - Deprecate armhf. As announced [here](https://www.linuxserver.io/blog/a-farewell-to-arm-hf)
* **21.06.23:** - Pin pycups version.
* **14.06.23:** - Create secondary venv in `/config` for pip installs.
* **07.06.23:** - Rebase to alpine 3.18, switch to cp311 wheels.
* **03.05.23:** - Deprecate arm32v7. Latest HA version with an arm32v7 build is `2023.4.6`.
* **16.11.22:** - Fix the dep conflict for google calendar.
* **23.09.22:** - Migrate to s6v3.
* **29.07.22:** - Improve usb device permission fix.
* **07.07.22:** - Rebase to alpine 3.16, switch to cp310 wheels.
* **07.05.22:** - Build matplotlib with the same Numpy version as HA req.
* **31.03.22:** - Install pycups.
* **07.03.22:** - Install PySwitchbot.
* **02.03.22:** - Update pip and use legacy resolver, clean up temp python files, reduce image size.
* **04.02.22:** - Always compile grpcio on arm32v7 due to pypi pushing a glibc only wheel.
* **12.12.21:** - Use the new `build.yaml` to determine HA base version.
* **25.09.21:** - Use the new lsio homeassistant wheel repo, instead of the HA wheels.
* **13.09.21:** - Build psycopg locally as the HA provided wheel does not seem to work properly.
* **13.09.21:** - Fix setcap in service. Build CISO8601 locally as the HA provided wheel does not seem to work properly.
* **12.09.21:** - Rebase to alpine 3.14. Build on native armhf.
* **09.08.21:** - Fixed broken build caused by missing dependency.
* **01.07.21:** - Remove HACS dependencies as it caused a crash in Home-assistant.
* **25.02.21:** - Add python dependencies from homeassistant base image.
* **07.02.21:** - Fix building from the wrong requirement file. Add ssh client & external DB libs.
* **06.02.21:** - Add iputils so ping works as non root user.
* **30.01.21:** - Initial Release.
