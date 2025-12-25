.PHONY: check
check: lint check-package.json

.PHONY: lint
lint: setup
	bun x @biomejs/biome check
	bun x -- bun-dx --package typescript tsc -- --noEmit --project ./tsconfig.json

.PHONY: format
format: setup
	bun x @biomejs/biome check --write

.PHONY: setup
setup:
	bun install --frozen-lockup

.PHONY: check-package.json
check-package.json:
	bun x -- bun-dx --package @cubing/dev-config package.json -- check

.PHONY: publish
publish:
	npm publish

.PHONY: prepublishOnly
prepublishOnly: clean check

.PHONY: clean
clean:

.PHONY: reset
reset: clean
	rm -rf ./node_modules

