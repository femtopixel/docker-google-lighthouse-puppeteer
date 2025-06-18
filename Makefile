VERSION ?= v12.6.1-puppeteer-v24.10.2-1.4.4
CACHE ?= --no-cache=1
.PHONY: docker build-docker publish-docker
docker: build-docker publish-docker
build-docker:
	docker build -t femtopixel/google-lighthouse-puppeteer -t femtopixel/google-lighthouse-puppeteer:${VERSION} --build-arg VERSION=${VERSION} ${CACHE} .
publish-docker:
	docker push femtopixel/google-lighthouse-puppeteer -a
