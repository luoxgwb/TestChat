FROM python:3.10

LABEL maintainer="foo@bar.com"
ARG TZ='Asia/Shanghai'

ARG CHATGPT_ON_WECHAT_VER

ENV BUILD_PREFIX=/app

RUN apt-get update  \
    && apt-get install -y --no-install-recommends \
        wget \
        curl  \
    && rm -rf /var/lib/apt/lists/* \
    && export BUILD_GITHUB_TAG=0.1.6-test \
    && wget -t 3 -T 30 -nv -O TestChat-${BUILD_GITHUB_TAG}.tar.gz \
            https://github.com/luoxgwb/TestChat/archive/refs/tags/${BUILD_GITHUB_TAG}.tar.gz \
    && tar -xzf TestChat-${BUILD_GITHUB_TAG}.tar.gz \
    && mv TestChat-${BUILD_GITHUB_TAG} ${BUILD_PREFIX} \
    && rm TestChat-${BUILD_GITHUB_TAG}.tar.gz \
    && cd ${BUILD_PREFIX} \
    && cp config-template.json ${BUILD_PREFIX}/config.json \
    && /usr/local/bin/python -m pip install --no-cache --upgrade pip \
    && pip install --no-cache -r requirements.txt

WORKDIR ${BUILD_PREFIX}

ADD /docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh \
    && groupadd -r noroot \
    && useradd -r -g noroot -s /bin/bash -d /home/noroot noroot \
    && chown -R noroot:noroot ${BUILD_PREFIX} 

USER noroot

ENTRYPOINT ["/entrypoint.sh"]