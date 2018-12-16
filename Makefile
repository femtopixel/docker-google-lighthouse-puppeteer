VERSION ?= v4.0.0-alpha.2-3.2.1-v1.11.0-0.4.1
CACHE ?= --no-cache=1
FULLVERSION ?= v4.0.0-alpha.2-3.2.1-v1.11.0-0.4.1
archs ?= amd64 i386 arm32v7
.PHONY: docker build-docker publish-docker latest
docker: build-docker publish-docker
	CACHE= make latest
build-docker:
	$(foreach arch,$(archs), \
		cat Dockerfile | sed -E "s/FROM femtopixel\/google-lighthouse:(.+)/FROM femtopixel\/google-lighthouse:\1-$(arch)/g" > .build; \
		docker build -t femtopixel/google-lighthouse-puppeteer:${VERSION}-$(arch) --build-arg VERSION=${VERSION}-$(arch) -f .build ${CACHE} .;\
	)
publish-docker:
	docker push femtopixel/google-lighthouse-puppeteer
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build-docker
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/latest/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
