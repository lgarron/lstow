.PHONY: check
check: lint check-package.json

.PHONY: lint
lint: lint-biome lint-typescript

.PHONY: lint-biome
lint-biome: setup
	bun x @biomejs/biome check

.PHONY: lint-typescript
lint-typescript: setup
	bun x -- bun-dx --package @typescript/native-preview tsgo -- --project ./tsconfig.json

.PHONY: lint-readme-cli-help
lint-readme-cli-help:
	bun x -- bun-dx --package readme-cli-help readme-cli-help -- check

.PHONY: format
format: format-biome format-readme-cli-help

.PHONY: format-biome
format-biome: setup
	bun x -- bun-dx --package @biomejs/biome biome -- check --write

.PHONY: format-readme-cli-help
format-readme-cli-help: setup
	bun x -- bun-dx --package readme-cli-help readme-cli-help -- update

.PHONY: setup
setup:
	bun install --frozen-lockfile

.PHONY: check-package.json
check-package.json:
	bun x -- bun-dx --package @cubing/dev-config package.json -- check

.PHONY: publish
publish:
	npm publish

.PHONY: prepublishOnly
prepublishOnly: clean check

RM_RF = bun -e 'process.argv.slice(1).map(p => process.getBuiltinModule("node:fs").rmSync(p, {recursive: true, force: true, maxRetries: 5}))' --

.PHONY: clean
clean:

.PHONY: reset
reset: clean
	${RM_RF} ./node_modules/
