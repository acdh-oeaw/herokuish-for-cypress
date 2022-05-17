FROM gliderlabs/herokuish

LABEL "maintainer" "Omar Siam <omar.siam@oeaw.ac.at>"

# Cypress dependencies

RUN apt-get update && apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb curl
ENV CYPRESS_CACHE_FOLDER /tmp/cache/cypress