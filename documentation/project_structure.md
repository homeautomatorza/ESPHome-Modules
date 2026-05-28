# Project Structure

This rebuild will keep the original modular idea, but the folder structure should
make module purpose and reuse boundaries easier to understand.

## Layout

| Path | Purpose |
| --- | --- |
| `boards/` | Board-specific package files and hardware defaults. |
| `common/` | Shared settings used by many devices. |
| `fonts/` | Font assets used by display packages. |
| `includes/` | C/C++ include files used by ESPHome configurations. |
| `peripherals/` | Displays, buses, touch controllers, and other attached hardware. |
| `sensors/` | Sensor packages, grouped by type and bus where useful. |
| `sample_secrets.yaml` | Example secrets file for local `secrets.yaml` values. |
| `documentation/` | Human-facing project documentation. |
| `documentation/changelogs/` | Dated project change notes. |
| `documentation/compatibilities/` | Compatibility references such as board support. |
| `documentation/headers/` | Header standards and examples. |

The local-only development folders `internal_documentation/`, `local_workbench/`,
`sample_projects/`, and `tools/` are intentionally ignored by git. They can be
used in the private rebuild workflow, but content should only move into tracked
public folders after it has been cleaned, validated, and documented for channel
users.

## Working Rules

- Keep package files reusable through substitutions or package `vars` where it
  makes the configuration clearer.
- Avoid hiding board-specific assumptions inside generic modules.
- Keep examples realistic and tested where possible.
- When a module is updated for a breaking ESPHome change, note that in the
  relevant changelog under `documentation/changelogs/`.

## Naming Convention

- Use lowercase folder and file names.
- Use underscores instead of spaces or hyphens.
- Use `.yaml` for ESPHome YAML modules.
- Use lowercase and underscores for package keys in usage examples.
- Keep GitHub-standard root files such as `README.md`, `LICENSE`, and
  `.github/FUNDING.yml` in their expected conventional form.
- Keep dated changelog and audit filenames in ISO date form for readability.
