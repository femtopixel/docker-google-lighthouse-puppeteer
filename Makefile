VERSION ?= v9.5.0-v13.5.2-1.3.2
CACHE ?= --no-cache=1
.PHONY: docker build-docker publish-docker
docker: build-docker publish-docker
build-docker:
	docker build -t femtopixel/google-lighthouse-puppeteer -t femtopixel/google-lighthouse-puppeteer:${VERSION} --build-arg VERSION=${VERSION} ${CACHE} .
publish-docker:
	docker push femtopixel/google-lighthouse-puppeteer -a
