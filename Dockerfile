ARG STACK_VERSION=
FROM gliderlabs/herokuish:latest$STACK_VERSION

LABEL "maintainer" "Omar Siam <omar.siam@oeaw.ac.at>"

# Cypress dependencies

ENV DEBIAN_FRONTEND=noninteractive \
    CYPRESS_CACHE_FOLDER=/tmp/cache/cypress \
    COREPACK_INTEGRITY_KEYS={\"npm\":[{\"expires\":\"2025-01-29T00:00:00.000Z\",\"keyid\":\"SHA256:jl3bwswu80PjjokCgh0o2w5c2U4LhQAE57gj9cz1kzA\",\"keytype\":\"ecdsa-sha2-nistp256\",\"scheme\":\"ecdsa-sha2-nistp256\",\"key\":\"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE1Olb3zMAFFxXKHiIkQO5cJ3Yhl5i6UPp+IhuteBJbuHcA5UogKo0EWtlWwW6KSaKoTNEYL7JlCQiVnkhBktUgg==\"},{\"expires\":null,\"keyid\":\"SHA256:DhQ8wR5APBvFHLF/+Tc+AYvPOdTpcIDqOhxsBHRwC7U\",\"keytype\":\"ecdsa-sha2-nistp256\",\"scheme\":\"ecdsa-sha2-nistp256\",\"key\":\"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEY6Ya7W++7aUPzvMTrezH6Ycx3c+HOKYCcNGybJZSCJq/fd7Qa8uuAKtdIkUQtQiEKERhAmE5lMMJhP8OkDOa2g==\"}]}
RUN \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' >/etc/apt/apt.conf.d/keep-cache && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libnss3 libxss1 libxtst6 xauth xvfb curl && \
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir /usr/bin -s && \
    fnm install 20 && \
    export PATH=$PATH:/root/.local/share/fnm/aliases/default/bin/ && \
    corepack enable && \
    cd /root && \
    mkdir playwright && cd playwright && \
    pnpm create playwright --quiet --install-deps && \
    cd / && rm -rf /root/.cache/ /root/.local/ /root/playwright && \
    apt-get clean
