FROM ghcr.io/linuxserver/baseimage-alpine:3.14

# set version label
ARG BUILD_DATE
ARG VERSION
ARG HASS_RELEASE
ARG HACS_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="saarg, roxedus"

# environment settings
ENV PIPFLAGS="--no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine/ --find-links https://wheel-index.linuxserver.io/homeassistant/" PYTHONPATH="${PYTHONPATH}:/pip-packages"

# copy local files
COPY root/ /

# https://github.com/home-assistant/core/pull/43771

# install packages
RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
  autoconf \
  ca-certificates \
  cargo \
  cmake \
  eudev-dev \
  ffmpeg-dev \
  gcc \
  g++ \
  jq \
  libffi-dev \
  jpeg-dev \
  libxml2-dev \
  libxslt-dev \
  make \
  postgresql-dev \
  python3-dev \
  unixodbc-dev \
  unzip && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
  bluez-deprecated \
  curl \
  eudev-libs \
  ffmpeg \
  iputils \
  libcap \
  libjpeg-turbo \
  libstdc++ \
  libxslt \
  mariadb-connector-c \
  mariadb-connector-c-dev \
  openssh-client \
  openssl \
  postgresql-libs \
  py3-pip \
  python3 \
  tiff && \
 echo "**** install homeassistant ****" && \
 mkdir -p \
  /tmp/core && \
  if [ -z ${HASS_RELEASE+x} ]; then \
  HASS_RELEASE=$(curl -sX GET https://api.github.com/repos/home-assistant/core/releases/latest \
  | jq -r .tag_name); \
 fi && \
 curl -o \
 /tmp/core.tar.gz -L \
 "https://github.com/home-assistant/core/archive/${HASS_RELEASE}.tar.gz" && \
 tar xf \
  /tmp/core.tar.gz -C \
  /tmp/core --strip-components=1 && \
 HASS_BASE=$(cat /tmp/core/build.json \
  | jq -r .build_from.amd64 \
  | cut -d: -f2) && \
 mkdir -p /pip-packages && \
 pip install --target /pip-packages --no-cache-dir --upgrade \
  distlib && \
 pip install --no-cache-dir --upgrade \
  cython \
  pip==20.2 \
  setuptools==57.5.0 \
  wheel && \
 cd /tmp/core && \
 pip install ${PIPFLAGS} \
  homeassistant==${HASS_RELEASE} && \
 pip install ${PIPFLAGS} \
  -r requirements_all.txt && \
 pip install ${PIPFLAGS} \
  -r https://raw.githubusercontent.com/home-assistant/docker/${HASS_BASE}/requirements.txt && \
 echo "**** cleanup ****" && \
 apk del --purge \
  build-dependencies && \
 rm -rf \
  /tmp/* \
  /root/.cache \
  /root/.cargo

# environment settings. used so pip packages installed by home assistant installs in /config
ENV HOME="/config"

# ports and volumes
EXPOSE 8123
VOLUME /config