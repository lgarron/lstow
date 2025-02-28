.PHONY: lint
lint: setup
	bun x @biomejs/biome check

.PHONY: format
format: setup
	bun x @biomejs/biome check --write

.PHONY: setup
setup:
	bun install --frozen-lockup

.PHONY: reset
reset:
	rm -rf ./node_modules

.PHONY: publish
publish:
	npm publish
