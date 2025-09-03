# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.21

# set version label
ARG BUILD_DATE
ARG VERSION
ARG HASS_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="saarg, roxedus"

ENV \
  S6_SERVICES_GRACETIME=240000 \
  UV_SYSTEM_PYTHON=true \
  UV_NO_CACHE=true \
  UV_EXTRA_INDEX_URL="https://wheels.home-assistant.io/musllinux-index/"

COPY root/etc/pip.conf /etc/

# install packages
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    autoconf \
    patch \
    bzip2-dev \
    coreutils \
    dpkg-dev dpkg \
    expat-dev \
    findutils \
    build-base \
    gdbm-dev \
    libc-dev \
    libffi-dev \
    libnsl-dev \
    openssl \
    openssl-dev \
    libtirpc-dev \
    linux-headers \
    make \
    mpdecimal-dev \
    ncurses-dev \
    pax-utils \
    readline-dev \
    sqlite-dev \
    tcl-dev \
    tk \
    tk-dev \
    xz-dev \
    zlib-dev \
    bluez-dev && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    bind-tools \
    bluez \
    bluez-deprecated \
    bluez-libs \
    cups-libs \
    curl \
    eudev-libs \
    ffmpeg \
    git \
    hwdata-usb \
    imlib2 \
    iperf3 \
    iputils \
    libcap \
    libftdi1 \
    libgpiod \
    libturbojpeg \
    libpulse \
    libstdc++ \
    libxslt \
    libzbar \
    mariadb-connector-c \
    net-tools \
    nmap \
    openssh-client \
    openssl \
    pianobar \
    postgresql-libs \
    pulseaudio-alsa \
    socat \
    tiff \
    xz && \
  echo "**** Retrieve versions ****" && \
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
  HA_PY_MAJOR=$(curl -fsL https://raw.githubusercontent.com/home-assistant/docker/${HASS_BASE}/build.yaml \
    | grep 'amd64: ' \
    | cut -d: -f3 \
    | sed 's|-alpine.*||') && \
  HASS_BASE_RELEASE=$(curl -sL https://api.github.com/repos/home-assistant/docker/releases) && \
  HASS_BASE_TIME=$(date -d $(echo $HASS_BASE_RELEASE | \
    jq -r ".[] | select(.tag_name | match(\"${HASS_BASE}\")) .published_at") +%s) && \
  for i in 0 1 2 3 4 5 6; do \
    HA_DOCKER_BASE_TIME=$(date -d $(curl -s "https://api.github.com/repos/home-assistant/docker-base/releases" | \
      jq -r ".[${i}].published_at") +%s); \
    if [ "${HASS_BASE_TIME}" -ge "${HA_DOCKER_BASE_TIME}" ]; then \
      HA_DOCKER_BASE=$(curl -s "https://api.github.com/repos/home-assistant/docker-base/releases" | jq -r ".[${i}].tag_name"); \
      echo "**** HA_DOCKER_BASE detected as version ${HA_DOCKER_BASE} ****"; \
      break; \
    fi; \
  done && \
  git clone --branch "${HA_DOCKER_BASE}" \
    --depth 1 https://github.com/home-assistant/docker-base.git \
    /tmp/ha-docker-base && \
  HA_PY_VERSION=$(cat /tmp/ha-docker-base/python/${HA_PY_MAJOR}/build.yaml \
    | grep 'PYTHON_VERSION: ' \
    | sed 's|.*PYTHON_VERSION: ||' \
    | sed 's|"||g') && \
  HA_JEMALLOC_VER=$(cat /tmp/ha-docker-base/alpine/build.yaml \
    | grep 'JEMALLOC_VERSION: ' \
    | sed 's|.*JEMALLOC_VERSION: ||' \
    | sed 's|"||g') && \
  HA_ALPINE_VER=$(curl -fsL https://raw.githubusercontent.com/home-assistant/docker/${HASS_BASE}/build.yaml \
    | grep 'amd64: ' \
    | cut -d: -f3 \
    | sed 's|.*-alpine||') && \
  IMAGE_ALPINE_VER=$(cat /etc/os-release | grep PRETTY_NAME | sed 's|.*Linux v||' | sed 's|"||') && \
  if [[ "${HA_ALPINE_VER}" != "${IMAGE_ALPINE_VER}" ]]; then \
    echo -e "**** Incorrect OS version detected, canceling build ****\n**** Upstream expected OS: ${HA_ALPINE_VER} ****\n**** Detected OS: ${IMAGE_ALPINE_VER}****"; \
    exit 1; \
  fi && \
  HA_PIP_VERSION=$(cat /tmp/ha-docker-base/python/${HA_PY_MAJOR}/build.yaml \
    | grep 'PIP_VERSION: ' \
    | sed 's|.*PIP_VERSION: ||' \
    | sed 's|"||g') && \
  HA_UV_VERSION=$(curl -fsL "https://raw.githubusercontent.com/home-assistant/core/refs/tags/${HASS_RELEASE}/Dockerfile" | grep 'install uv==' | sed 's|RUN pip3 install uv==||') && \
  HA_GO2RTC_VERSION=$(curl -fsL "https://raw.githubusercontent.com/home-assistant/core/refs/tags/${HASS_RELEASE}/Dockerfile" | grep 'AlexxIT/go2rtc/releases/download' | sed -r 's|^.*AlexxIT/go2rtc/releases/download/(.*)/go2rtc_linux.*$|\1|') && \
  curl -o \
    /bin/go2rtc -fL \
    "https://github.com/AlexxIT/go2rtc/releases/download/${HA_GO2RTC_VERSION}/go2rtc_linux_amd64" && \
  chmod +x /bin/go2rtc && \
  echo "**** Quick test go2rtc binary: ****" && \
  /bin/go2rtc --version && \
  echo "**** install jemalloc ****" && \
  git clone --branch ${HA_JEMALLOC_VER} \
    --depth 1 "https://github.com/jemalloc/jemalloc" \
    /tmp/jemalloc && \
  cd /tmp/jemalloc && \
  ./autogen.sh \
    --with-lg-page=16 && \
  make -j "$(nproc)" && \
  make install_lib_shared install_bin && \
  echo "**** install python ****" && \
  PY_HA_ALPINE_VER=$(echo "${HA_ALPINE_VER}" | sed 's|\.||') && \
  PY_RELEASE_TAG=$(curl -s https://api.github.com/repos/linuxserver/docker-python/releases \
    | jq -r "first(.[] | select(.tag_name | startswith(\"alpine${PY_HA_ALPINE_VER}-${HA_PY_VERSION}\"))) | .tag_name") && \
  if [ -n "${PY_RELEASE_TAG}" ]; then \
    echo "**** Installing python from the linuxserver python repo release ${PY_RELEASE_TAG} ****" && \
    curl -o \
      /tmp/python.tar.gz -L \
      "https://github.com/linuxserver/docker-python/releases/download/${PY_RELEASE_TAG}/python-amd64.tar.gz" && \
    tar xf \
      /tmp/python.tar.gz -C \
      /usr/local && \
    apk add --no-cache $(cat /usr/local/python-deps.txt); \
  else \
    echo "**** Python version ${HA_PY_VERSION} not found in the linuxserver repo, compiling from source ****" && \
    mkdir -p /tmp/python && \
    curl -o \
      /tmp/python.tar.xz -L \
      "https://www.python.org/ftp/python/${HA_PY_VERSION}/Python-${HA_PY_VERSION}.tar.xz" && \
    tar xf \
      /tmp/python.tar.xz -C \
      /tmp/python --strip-components=1 && \
    for patch in /tmp/ha-docker-base/python/${HA_PY_MAJOR}/*.patch; do \
      patch -d /tmp/python -p 1 < "${patch}"; \
    done && \
    cd /tmp/python && \
    ./configure \
      --build="x86_64-linux-musl" \
      --enable-loadable-sqlite-extensions \
      --enable-optimizations \
      --enable-option-checking=fatal \
      --enable-shared \
      --with-lto \
      --with-system-libmpdec \
      --with-system-expat \
      --without-ensurepip \
      --without-static-libpython && \
    make -j "$(nproc)" \
      LDFLAGS="-Wl,--strip-all" \
      CFLAGS="-fno-semantic-interposition -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free" \
      EXTRA_CFLAGS="-DTHREAD_STACK_SIZE=0x100000" && \
    make install && \
    find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec scanelf --needed --nobanner --format '%n#p' '{}' ';' \
      | tr ',' '\n' \
      | sort -u \
      | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
      | xargs -rt apk add --no-cache && \
    find /usr/local -depth \
      \( \
        -type d -a \( -name test -o -name tests \) \
      \) -exec rm -rf '{}' + && \
    cd /usr/local/bin && \
    ln -s idle3 idle && \
    ln -s pydoc3 pydoc && \
    ln -s python3 python && \
    ln -s python3-config python-config && \
    curl -o \
      /tmp/get-pip.py -L \
      "https://bootstrap.pypa.io/get-pip.py" && \
    /usr/local/bin/python3 /tmp/get-pip.py \
      --disable-pip-version-check \
      --no-cache-dir \
      pip==${HA_PIP_VERSION} && \
    find /usr/local -depth \
      \( \
        -type d -a \( -name test -o -name tests \) \
      \) -exec rm -rf '{}' + ; \
  fi && \
  echo "**** install homeassistant ****" && \
  cd /tmp/core && \
  pip3 install uv==${HA_UV_VERSION} && \
  uv pip install --no-build \
    -r https://raw.githubusercontent.com/home-assistant/docker/${HASS_BASE}/requirements.txt && \
  uv pip install --no-build \
    -r requirements.txt && \
  PYCUPS_VER=$(grep "pycups" requirements_all.txt | sed 's|.*==||') && \
  uv pip install --no-build \
      -r requirements_all.txt \
      isal \
      pycups==${PYCUPS_VER} && \
  uv pip install \
    homeassistant==${HASS_RELEASE} && \
  for cleanfiles in *.pyc *.pyo; do \
    find /usr/local/lib/python3.*  -iname "${cleanfiles}" -exec rm -f '{}' + ; \
  done && \
  chown -R root:7310  /usr/local && \
  chmod -R g+w /usr/local && \
  groupadd lsio && \
  groupmod -g 7310 lsio && \
  mv "/usr/local/lib/python${HA_PY_MAJOR}" "/usr/local/lib/python${HA_PY_MAJOR}.bak" && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    /root/.cache \
    /root/.cargo

# environment settings. used so pip packages installed by home assistant installs in /config
ENV HOME="/config"

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8123
VOLUME /config
