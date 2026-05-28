# Local Workbench

This folder is for private ESPHome device files and package experiments that
are not ready to be committed.

Everything in this folder is ignored by git except this README, this folder's
`.gitignore`, and the empty folder placeholders.

## Suggested Layout

Use one folder per device or physical project:

```text
local_workbench/
  devices/
    weather_station_v4/
      device.yaml
      packages/
        display.yaml
        sensors.yaml
```

## Naming Conventions

Use **device file** for the top-level ESPHome YAML that represents one complete,
compilable device.

Use `device.yaml` as the standard filename for that top-level file. The folder
name carries the device identity, so the filename can stay predictable:

```text
local_workbench/devices/<device_name>/device.yaml
```

Use lowercase and underscores for folder names:

```text
minimal_validation_sample
weather_station_v4
garage_presence_node
```

Avoid putting the device name into the top-level filename unless there is a
specific reason. Prefer this:

```text
local_workbench/devices/weather_station_v4/device.yaml
```

over this:

```text
local_workbench/devices/weather_station_v4/weather_station_v4_master.yaml
```

## Device-Exclusive Files

Use `packages/` under the device folder for private project-specific fragments
that are not ready to move into the public repo.

Examples:

```text
local_workbench/devices/<device_name>/packages/display.yaml
local_workbench/devices/<device_name>/packages/sensors.yaml
local_workbench/devices/<device_name>/packages/local_calibration.yaml
```

Keep these files device-exclusive when they contain:

- hardware wiring that only belongs to that physical build
- calibration constants for one sensor or one device
- temporary experiments
- YAML that still needs cleanup before becoming reusable

When a device-exclusive file becomes reusable, move it out of the workbench and
into the correct public folder, such as `sensors/`, `peripherals/`, `common/`,
or `sample_projects/`.

## Include Strategy

While a file lives in `local_workbench/`, use local relative includes back to the
repo root. This keeps development fast and validates the local files we are
actively changing:

```yaml
packages:
  settings: !include ../../../common/core/settings.yaml
  board: !include ../../../boards/esp32/d1_mini.yaml
```

Production-facing examples should keep repo-reference usage in mind. When the
device is promoted into `sample_projects/`, re-check the include strategy. If
the sample is meant to show real external repo usage, convert it to repo
references and validate/build it again before committing.

That second validation matters because local relative includes and repo
references fail in different ways.

Public samples should default to `common/network/wifi_dynamicip.yaml`. Use
`common/network/wifi_fixedip.yaml` only when the sample is specifically about
fixed networking or the README explains why a static address is required.

## Header Standard

Use the current header standard from `documentation/headers/header.md`.

Preferred section order:

- component or device name
- author, web, version, and licence
- warning
- specifications
- bill of materials
- references
- usage
- package exposes
- notes

Use only the sections that add value. For a complete physical build, prefer
`Bill of Materials` for the hardware list. For a small reusable YAML package,
it is fine to omit specifications or bill of materials when they do not add
anything useful.

## Validation

Run ESPHome from the repository root:

```bash
.venv/bin/esphome config local_workbench/devices/<device_name>/device.yaml
```

For devices or packages that declare compatibility notes, prefer the wrapper so
the notes are shown before config validation or compile:

```bash
ruby tools/esphome_with_notes.rb config local_workbench/devices/<device_name>/device.yaml
ruby tools/esphome_with_notes.rb compile local_workbench/devices/<device_name>/device.yaml
```

Because these files live below the repository root, include paths normally need
to walk back to the repo root. For example:

```yaml
packages:
  settings: !include ../../../common/core/settings.yaml
  board: !include ../../../boards/esp32/d1_mini.yaml
```

If a workbench device moves deeper or shallower in the folder tree, adjust the
`../` path depth accordingly.

## Promotion Checklist

Before moving a workbench device into `sample_projects/`, confirm:

- `device.yaml` validates with ESPHome.
- any device-exclusive packages are either still private or moved into public
  package folders intentionally
- secrets are represented by `!secret` keys, not real values
- include paths or repo references are updated for the destination folder
- WiFi uses `wifi_dynamicip.yaml` unless static networking is intentional
- the sample has a short README if the build needs wiring notes
