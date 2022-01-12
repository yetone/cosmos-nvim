IMG := yetone/cosmos-nvim:latest

build:
	docker build -t ${IMG} .
	docker push ${IMG}

