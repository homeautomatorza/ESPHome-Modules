# Contributing

Contributions are welcome. If you improve the framework, documentation, examples,
or cookbook projects, your work will be credited through GitHub's normal
contributor history when it is merged.

This project is still under active rebuild, so the standards are intentionally
strict. The goal is not to make contributing difficult; the goal is to keep the
framework useful, predictable, and honest for people building real ESPHome
devices.

## Good Contributions

Useful contributions include:

- fixes for broken YAML, stale references, typos, or unclear documentation
- new or improved board, sensor, peripheral, common, or display packages
- cookbook project ideas with enough detail to reproduce the build
- validation notes from real hardware
- compatibility notes for ESPHome, Home Assistant, boards, or sensors
- small improvements that reduce copy-paste or make modules easier to reuse

If you want to make a large structural change, please open an issue or discussion
first so we can agree on the direction before you spend a lot of time on it.

## Project Standards

Please follow the patterns used in the Home Automator ZA tutorial series and the
current files in this repository.

Contributed files should:

- use ESPHome packages where reuse makes sense
- avoid copying large blocks of repeated YAML between devices
- live in the correct folder for their role
- use clear names and stable IDs
- include the current project header pattern
- list required substitutions, secrets, hardware, and references
- keep licence metadata aligned with the project unless there is a clear reason
  not to
- avoid private paths, private device names, credentials, tokens, Wi-Fi details,
  or local network information

## Folder Guide

Use the existing folder structure:

- `boards/` for board definitions, pins, buses, and hardware defaults
- `common/` for shared core, network, display, time, and support packages
- `peripherals/` for reusable peripheral packages
- `sensors/` for reusable sensor packages
- `recipes/boilerplates/` for starter device YAML
- `recipes/samples/` for focused examples
- `recipes/projects/` for cookbook-style complete builds
- `wiki/` for repo-local wiki source

If a file does not clearly belong in one of those places, open an issue before
adding a new top-level folder.

## Headers And Metadata

Every public YAML package should include the current header pattern used in the
repository. At minimum, the header should explain:

- what the package is
- how to include it
- what it exposes
- author or source information
- version
- licence
- useful ESPHome or hardware references
- compatibility and validation status
- important notes, warnings, or limitations

Do not claim a module is tested unless it has actually been tested on hardware.

## Testing And Sign-Off

Please test the files you add or change and describe what you tested in the pull
request.

Use accurate validation language:

- `Config validated` means ESPHome accepted the YAML.
- `Compile validated` means ESPHome produced firmware.
- `Hardware validated` means the module or project was tested on real hardware.
- `Needs validation` means it may parse or compile, but still needs real-world
  confirmation.

Automated checks are useful evidence, but they do not replace hardware testing.
If you cannot physically test the hardware, say so clearly.

For pull requests, include:

- ESPHome version used
- board or device used, if hardware was tested
- whether config validation passed
- whether compile validation passed
- whether hardware validation passed
- any known limitations or follow-up work

## Pull Request Checklist

Before opening a pull request, please check that:

- the change is focused and easy to review
- files are in the correct folders
- YAML is formatted consistently with nearby files
- headers and metadata are present where needed
- no secrets or private details are included
- documentation was updated when behavior changed
- validation claims match the evidence
- breaking changes are clearly called out

## Licence

This project uses CC0 1.0 Universal unless a file says otherwise. By
contributing, you agree that your contribution can be distributed under the
project licence.

The licence may not be changed casually. Other contribution rules may evolve as
the project grows, but licence changes require explicit project-owner approval.

## Review And Merge Decisions

The repository owner has the final decision on what gets merged. A contribution
may be delayed, changed, or declined if it does not fit the framework direction,
has unclear validation, introduces private information, or would be difficult to
maintain.

That is not personal. The aim is to keep the public framework reliable,
understandable, and useful for real ESPHome projects.
