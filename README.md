# ESPHome Modular Rebuild 2026

This repository is the 2026 rebuild of the Home Automator ZA ESPHome modular
configuration project. The goal is to keep reusable ESPHome packages, board
templates, sensors, peripherals, and starter device files clean, testable, and
current with modern ESPHome releases.

The project is based on Pascal Parent's ESPHome modularisation series for Home
Automator ZA:

- YouTube channel: https://www.youtube.com/@homeautomatorza
- Original modules repository: https://github.com/homeautomatorza/ESPHome-Modules

## Current Focus

- Preserve the working modular approach from the original project.
- Bring YAML modules up to date with current ESPHome behaviour.
- Improve folder structure, naming, and documentation.
- Keep compatibility data, file header standards, and changelogs visible.
- Validate changes against real boards and clearly mark anything untested.

## Repository Map

| Path | Purpose |
| --- | --- |
| `boards/` | Board-specific package files and hardware defaults. |
| `common/` | Shared core, display, network, and time packages. |
| `documentation/` | Project documentation, standards, compatibility notes, and usage guidance. |
| `documentation/changelogs/` | Historical and future project changelogs. |
| `documentation/compatibilities/` | Compatibility references, starting with board support. |
| `documentation/headers/` | File header standards and samples. |
| `fonts/` | Font assets used by display packages. |
| `includes/` | C/C++ include files used by ESPHome configurations. |
| `peripherals/` | Display, bus, touch, and other attached hardware packages. |
| `sensors/` | Sensor packages, grouped by type and bus where useful. |
| `sample_secrets.yaml` | Example secrets file. Copy values into local `secrets.yaml`. |

The real root `secrets.yaml` file is intentionally ignored by git.
Local-only folders such as `local_workbench/`, `internal_documentation/`,
`sample_projects/`, and `tools/` are also ignored by git until their contents are
ready for public release.

## Documentation

- [Documentation index](documentation/index.md)
- [Getting started](documentation/getting_started.md)
- [Compatibility](documentation/compatibilities/README.md)
- [Header samples](documentation/headers/header.md)
- [Project structure](documentation/project_structure.md)
- [Changelog index](documentation/changelogs/README.md)

## Compatibility

The current compatibility list was carried forward from the original project and
should be treated as a living document. Tested status should only be marked when
the board or module has actually been validated.

## Secrets

Use `sample_secrets.yaml` as the reference for required secret keys. Create a
local `secrets.yaml` in the repository root for real values. Do not commit real
passwords, tokens, API keys, WiFi credentials, or private network details.

## Licence

The original ESPHome Modules project uses CC0 1.0 Universal. Keep licence
metadata in module headers aligned with the project licence unless a file has a
specific reason to do otherwise.

See [LICENSE](LICENSE) for the full licence text.

## Contributing Standard

Contributions and internal module updates should follow these rules:

1. Keep files in their correct module category.
2. Include the appropriate file header.
3. Mark tested status truthfully.
4. Record meaningful changes in `documentation/changelogs/`.
5. Prefer small, reviewable updates over broad undocumented rewrites.
