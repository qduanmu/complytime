# complyctl

[![OpenSSF Best Practices status](https://www.bestpractices.dev/projects/9761/badge)](https://www.bestpractices.dev/projects/9761)
[![GoDoc](https://img.shields.io/static/v1?label=godoc&message=reference&color=blue)](https://pkg.go.dev/github.com/complytime/complyctl)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/complytime/complyctl/badge)](https://scorecard.dev/viewer/?uri=github.com/complyctl/complyctl)

ComplyCTL leverages [OSCAL](https://github.com/usnistgov/OSCAL/) to perform compliance assessment activities, using plugins for each stage of the lifecycle.

## Documentation

:paperclip: [Installation](./docs/INSTALLATION.md)\
:paperclip: [Quick Start](./docs/QUICK_START.md)\
:paperclip: [Sample Component Definition](./docs/samples/sample-component-definition.json)

### Basic Usage

Determine the baseline you want to run a scan for and create an OSCAL [Assessment Plan](https://pages.nist.gov/OSCAL/learn/concepts/layer/assessment/assessment-plan/). The Assessment
Plan will act as configuration to guide the complyctl generation and scanning operations.

```bash
complyctl list
...
# Table appears with options. Look at the Framework ID column.
```

```bash
complyctl info <framework-id>
...
# Display information about a framework's controls and rules.
```

```bash
complyctl plan <framework-id>
...
# The file will be written out to assessment-plan.json in the specified workspace.
# Defaults to current working directory.

cat assessment-plan.json
# The default assessment-plan.json will be available in the complytime workspace (complytime/assessment-plan.json).

complyctl plan <framework-id> --dry-run
# See the default contents of the assessment-plan.json.

complyctl plan <framework-id> --dry-run --out config.yml
# Customize the assessment-plan.json with the "out" flag. Updates can be made in the config.yml.

complyctl plan <framework-id> --scope-config config.yml
# The config.yml will be loaded when passing "scope-config" to customize the assessment-plan.json.
```

Run the generate command to `generate` policy artifacts in the workspace and run the `scan` command to execute the generated artifacts and get results.

```bash
complyctl generate
...
complyctl scan

# The results will be written to assessment-results.json in the specified workspace.
# Defaults to current working directory under folder "complytime".

complyctl scan --with-md

# Both assessment-results.md and assessment-results.json will be written in the specified workspace.
# Defaults to current working directory under folder "complytime".
```

## Contributing

:paperclip: Read the [contributing guidelines](./docs/CONTRIBUTING.md)\
:paperclip: Read the [style guide](./docs/STYLE_GUIDE.md)\
:paperclip: Read and agree to the [Code of Conduct](./docs/CODE_OF_CONDUCT.md)

*Interested in writing a plugin?* See the [plugin guide](./docs/PLUGIN_GUIDE.md).
