# Initial Inventory Audit

Date: 2026-05-11

## Scope

This audit covers the first copied baseline in
`pascal-parent/ESPHome-Modular-Rebuild-2026` after the original module files
were added to the rebuild repository.

The goal was not to rewrite YAML yet. The goal was to identify the first set of
safe work items for the Kanban board and roadmap.

## Inventory Summary

| Area | Count / Notes |
| --- | --- |
| YAML/YML files | 75 files parsed by a generic YAML parser. |
| Board package files | ESP32, ESP8266, and Raspberry Pi Pico board packages are present. |
| Common packages | Core, display, network, and time packages are present. |
| Sensors | Bluetooth, analogue, binary, I2C, one-wire, and UART sensor packages are present. |
| Peripherals | Display package files are present. |
| Deferred components | `documentation/deferred_components/hardware_info` is preserved for later Pico work. |
| Sample projects | Folder exists with a placeholder README. |

## Checks Performed

- Confirmed `main` was clean before the audit.
- Confirmed generic YAML parsing passed for 75 YAML/YML files.
- Confirmed no tracked files have executable file mode.
- Confirmed `.DS_Store` files are ignored.
- Confirmed root `secrets.yaml` is ignored.
- Confirmed `sample_secrets.yaml` is trackable.
- Scanned for obvious secret placeholders and credential-looking strings.
- Scanned live `!include` references separately from commented usage examples.
- Scanned for WIP, beta, untested, version, and ESPHome compatibility markers.

## Important Limitations

- The ESPHome CLI is not installed in this shell, so this audit did not run
  `esphome config` or compile checks.
- Generic YAML parsing does not validate ESPHome-specific keys, component
  schemas, package substitutions, or C++ custom component builds.
- Compatibility table findings below are based on local file content, not fresh
  hardware testing.

## Findings

### P1: Board Secret Bridge Paths Need Fixing

The live include scan found seven active `!include` lines. Three board-family
bridge files appear to point to a missing path:

| File | Current include | Resolution concern |
| --- | --- | --- |
| `boards/esp32/secret.yaml` | `<<: !include ../secrets.yaml` | Resolves to `boards/secrets.yaml`, but the repo has `boards/secret.yaml`. |
| `boards/esp8266/secret.yaml` | `<<: !include ../secrets.yaml` | Resolves to `boards/secrets.yaml`, but the repo has `boards/secret.yaml`. |
| `boards/raspberry_pi/secret.yaml` | `<<: !include ../secrets.yaml` | Resolves to `boards/secrets.yaml`, but the repo has `boards/secret.yaml`. |

The likely intent is either:

- rename `boards/secret.yaml` to `boards/secrets.yaml`, or
- change the board-family bridge files to include `../secret.yaml`.

This should be fixed before real device examples rely on those include bridges.

### P1: `hardware_info` Custom Component Looks Incomplete

`hardware_info` appeared internally inconsistent in the copied baseline and was
later moved out of the active ESPHome `components/` tree to
`documentation/deferred_components/hardware_info` for later Pico-specific work.
The copied component had these issues:

- `hardware_info.py` references `empty_text_sensor_ns`, but that name is not
  defined.
- `hardware_info.cpp` implements `EmptyTextSensor::setup()` and
  `EmptyTextSensor::dump_config()`.
- `hardware_info.h` declares `class HardwareInfo`.
- The C++ namespace closing comment still references `empty_text_sensor`.

This is likely to fail ESPHome code generation or C++ compilation if re-enabled
without repair.

### P1: ESPHome CLI Validation Is Needed

The repository currently has no local ESPHome validation command, sample device
build target, or CI workflow. The generic YAML check passed, but ESPHome package
syntax and custom component integration still need real validation.

Recommended next steps:

1. Add one minimal sample project that includes common settings, one board, and
   a network package.
2. Install or document the ESPHome CLI/runtime used for validation.
3. Run `esphome config` against the sample project.
4. Add a GitHub Actions workflow once the local validation path is stable.

### P2: Compatibility Table Needs Reconciliation

`documentation/compatibilities/boards.md` was preserved from the original
project, but some rows appear stale or inconsistent with the copied board files:

- `Generic ESP32-C6 Super Mini` is listed with chip model `ESP32-C3 FN4`, while
  `boards/esp32/c6_super_mini.yaml` describes an ESP32-C6 board.
- `Espressif ESP32 S3 Super Mini` is listed with chip model `ESP32-C3 FN4`,
  while `boards/esp32/s3_super_mini.yaml` describes an ESP32-S3 board.
- `boards/esp32/s3_super_mini.yaml` says `Not Tested` and `Compiled OK`, while
  the compatibility table marks it tested.
- `boards/raspberry_pi/2040_pico_w.yaml` says `Unfinished` and `Requires more
  testing`, while the compatibility table marks it tested.
- Several board files have package usage examples pointing to old `common/...`
  or singular `board/...` paths instead of the current root `boards/...` layout.

This should become a structured compatibility cleanup rather than one-off table
edits.

### P2: Header And Comment Cleanup Is Broad

The preserved YAML files contain repeated spelling and wording drift. Examples:

- `Licence: CCO 1.0` should probably be `Licence: CC0 1.0`.
- `Referance` appears in several board headers.
- `folowing`, `depercated`, `Capasitive`, and `Use at your own risks` appear in
  comments and headers.

These do not block function, but they affect the professionalism of the public
project and should be handled as a batch once behaviour-critical issues are
tracked.

### P2: Naming Conventions Need A Decision

The repo originally had a mixed naming style: for example, `sensors/Bluetooth`
used an uppercase directory and several module filenames used hyphens instead
of underscores.

This is not urgent, but deciding the naming convention early will avoid churn in
examples and documentation.

### P3: Beta And Untested Boards Need Explicit Tracking

The following areas should have explicit cards or compatibility statuses:

- ESP32-C6 boards marked beta.
- ESP32-H2 Zigbee board marked coming soon / not tested.
- Raspberry Pi Pico W and Pico 2 W marked beta or requiring more testing.
- ESP32 S3 Super Mini marked not tested in-file but tested in the compatibility
  table.

## Recommended First Work Sequence

1. Fix board secret bridge include paths.
2. Repair or re-enable deferred `hardware_info` only when the Pico workstream
   needs it.
3. Create one minimal sample project for validation.
4. Establish local ESPHome CLI validation.
5. Reconcile the compatibility table with board file truth.
6. Normalize header wording and usage examples.
7. Decide naming conventions and apply them in a controlled refactor.
