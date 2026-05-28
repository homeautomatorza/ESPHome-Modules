# Local Workbench

`local_workbench/` is the private development area for ESPHome device files and
physical project package compositions that are not ready for GitHub.

The folder exists in the repository, but its working contents are ignored by
git. Only the guard files and local README are tracked.

## Naming

Use **device file** for the top-level ESPHome YAML that represents one
compilable device configuration.

Recommended layout:

```text
local_workbench/devices/<device_name>/device.yaml
```

Use `device.yaml` as the master/top-level file inside each private device
folder. The folder name carries the device identity, while the filename stays
predictable.

Use private package fragments only when the device needs local pieces that are
not ready for the public repo:

```text
local_workbench/devices/<device_name>/packages/<package_name>.yaml
```

## Validation

ESPHome can validate and compile files from this folder as long as the include
paths are correct:

```bash
.venv/bin/esphome config local_workbench/devices/<device_name>/device.yaml
```

Example package paths from `local_workbench/devices/<device_name>/device.yaml`:

```yaml
packages:
  settings: !include ../../../common/core/settings.yaml
  board: !include ../../../boards/esp32/d1_mini.yaml
```

Workbench files should use local relative includes while they are being built
and tested. Production-facing samples should keep repo-reference usage in mind.
When a workbench device is promoted into `sample_projects/`, validate it again
after converting include paths or repo references for the destination.

The private files should stay local until they are cleaned, validated,
documented, and intentionally moved into public repo folders.
