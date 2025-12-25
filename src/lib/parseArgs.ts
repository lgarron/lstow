import { argv } from "node:process";
import {
  argument,
  choice,
  map,
  message,
  object,
  option,
  optional,
} from "@optique/core";
import { path, run } from "@optique/run";
import { Path } from "path-class";
import { version as VERSION } from "../../package.json";

export function parseArgs() {
  return run(
    object({
      dryRun: option("--dry-run"),
      mkdirDestinationRootIfMissing: optional(
        map(
          option(
            "--mkdir-destination-root-if-missing",
            choice(["true", "false"]),
          ),
          Boolean,
        ),
      ),
      sourceDir: map(
        argument(
          path({ mustExist: true, type: "directory", metavar: "SOURCE_DIR" }),
        ),
        Path.fromString,
      ),
      destinationDir: map(
        argument(path({ metavar: "DESTINATION_DIR" })),
        Path.fromString,
      ),
    }),
    {
      programName: new Path(argv[1]).basename.path,
      description: message`Simple \`stow\` alternative.`,
      help: "option",
      completion: {
        mode: "option",
        name: "plural",
      },
      version: {
        mode: "option",
        value: VERSION,
      },
    },
  );
}
