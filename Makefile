IMG := yetone/cosmosvim:latest

build:
	docker build -t ${IMG} .
	docker push ${IMG}

