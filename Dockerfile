FROM ghcr.io/linuxserver/baseimage-alpine:3.18

# set version label
ARG BUILD_DATE
ARG VERSION
ARG HASS_RELEASE
ARG HACS_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="saarg, roxedus"

# environment settings
ENV \
  PATH="/config/lsiopy/bin:${PATH}" \
  PIPFLAGS="--no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.18/ --find-links https://wheel-index.linuxserver.io/homeassistant-3.18/" \
  PYTHONPATH="/config/lsiopy/lib/python3.11/site-packages:/lsiopy/lib/python3.11/site-packages" \
  PIP_DISABLE_PIP_VERSION_CHECK=1

# copy local files
COPY root/ /

# install packages
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    autoconf \
    ca-certificates \
    cargo \
    cmake \
    cups-dev \
    eudev-dev \
    ffmpeg-dev \
    gcc \
    glib-dev \
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
    bluez \
    bluez-deprecated \
    bluez-libs \
    cups-libs \
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
  HASS_BASE=$(cat /tmp/core/build.yaml \
    | grep 'amd64: ' \
    | cut -d: -f3) && \
  python3 -m venv /lsiopy && \
  pip install --no-cache-dir --upgrade \
    cython \
    "pip>=21.0,<22.1" \
    pyparsing \
    setuptools \
    wheel && \
  cd /tmp/core && \
  NUMPY_VER=$(grep "numpy" requirements_all.txt) && \
  PYCUPS_VER=$(grep "pycups" requirements_all.txt | sed 's|.*==||') && \
  pip install ${PIPFLAGS} \
    "${NUMPY_VER}" && \
  pip install ${PIPFLAGS} \
    -r https://raw.githubusercontent.com/home-assistant/docker/${HASS_BASE}/requirements.txt && \
  pip install ${PIPFLAGS} \
    -r requirements_all.txt && \
  PYTHONPATH="" pip uninstall -y asyncio || : && \
  pip install ${PIPFLAGS} \
    pycups==${PYCUPS_VER} && \
  pip install ${PIPFLAGS} \
    homeassistant==${HASS_RELEASE} && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  for cleanfiles in *.pyc *.pyo; \
    do \
    find /lsiopy/lib/python3.*  -iname "${cleanfiles}" -exec rm -f '{}' + \
    ; done && \
  rm -rf \
    /tmp/* \
    /root/.cache \
    /root/.cargo

# environment settings. used so pip packages installed by home assistant installs in /config
ENV HOME="/config"

# ports and volumes
EXPOSE 8123
VOLUME /config
