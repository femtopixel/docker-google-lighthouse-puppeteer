FROM femtopixel/google-lighthouse:v6.0.0-beta.0

ARG VERSION=v3.0.0
LABEL maintainer="Jay MOULIN <https://jaymoulin.me/femtopixel/docker-google-lighthouse-puppeteer> <https://twitter.com/MoulinJay>"
LABEL version="${VERSION}"

#https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md
USER root
RUN apt-get update; apt-get install libgconf-2-4 -y && rm -Rf /var/lib/apt/lists/*
USER chrome
RUN mkdir -p /home/chrome/testcases && cd /home/chrome && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1 yarn global add google-lighthouse-puppeteer
COPY entrypoint.sh /usr/bin/entrypoint
WORKDIR /home/chrome
VOLUME /home/chrome/testcases
ENV PATH="/home/chrome/bin:/home/chrome/.yarn/bin:${PATH}"
ENV CHROME_PATH=/usr/bin/chromium
ENTRYPOINT ["entrypoint"]
