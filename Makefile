BASE_IMG := yetone/cosmos-nvim-base:latest
IMG := yetone/cosmos-nvim:latest

build-base-img:
	docker build -t ${BASE_IMG} -f Dockerfile-base .
	docker push ${BASE_IMG}

build-img:
	docker build -t ${IMG} .
	docker push ${IMG}

luacheck:
	luacheck `find -name  "*.lua"` --codes

stylecheck:
	docker run --rm -v ${PWD}:/app -w /app yetone/stylua:latest stylua --check .

stylefix:
	docker run --rm -v ${PWD}:/app -w /app yetone/stylua:latest stylua -g '*.lua' -- .

build-stylua-img:
	docker build -t yetone/stylua:latest -f Dockerfile-stylua .
	docker push yetone/stylua:latest

