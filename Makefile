BASE_IMG := yetone/cosmos-nvim-base:latest
IMG := yetone/cosmos-nvim:latest

build-base-img:
	docker build -t ${BASE_IMG} -f Dockerfile-base .
	docker push ${BASE_IMG}

build-img:
	docker build -t ${IMG} .
	docker push ${IMG}

