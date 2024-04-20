VERSION ?= v11.7.1-puppeteer-v22.6.5-1.3.3
CACHE ?= --no-cache=1
.PHONY: docker build-docker publish-docker
docker: build-docker publish-docker
build-docker:
	docker build -t femtopixel/google-lighthouse-puppeteer -t femtopixel/google-lighthouse-puppeteer:${VERSION} --build-arg VERSION=${VERSION} ${CACHE} .
publish-docker:
	docker push femtopixel/google-lighthouse-puppeteer -a
