ARG STACK_VERSION=
FROM gliderlabs/herokuish:latest$STACK_VERSION

LABEL "maintainer" "Omar Siam <omar.siam@oeaw.ac.at>"

# Cypress dependencies

ENV DEBIAN_FRONTEND=noninteractive \
    CYPRESS_CACHE_FOLDER=/tmp/cache/cypress
RUN \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' >/etc/apt/apt.conf.d/keep-cache && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb curl && \
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir /usr/bin -s && \
    fnm install 20 && \
    export PATH=$PATH:/root/.local/share/fnm/aliases/default/bin/ && \
    corepack enable && \
    cd /root && \
    mkdir playwright && cd playwright && \
    pnpm create playwright --quiet --install-deps && \
    cd / && rm -rf /root/.cache/ /root/.local/ /root/playwright && \
    apt-get clean
