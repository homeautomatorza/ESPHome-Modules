# Modernization Audit (2026/05/12)

Audit target: board, common, peripheral, and sensor YAML packages.

Local ESPHome version used for validation: `2026.4.5`.

## Safe Fixes Applied

- Corrected package substitutions that still used `$name` instead of `${name}`:
  - `sensors/analogue/tds_sensor.yaml`
  - `sensors/i2c/ltr390.yaml`
  - `sensors/i2c/sgp40.yaml`
- Cleared the inherited `voltage` device class from the TDS ppm output sensor.
- Normalized current package headers from `CCO` to `CC0`.
- Corrected preserved spelling drift in active package headers and comments:
  - `Referance` -> `Reference`
  - `folowing` -> `following`
  - `depercated` -> `deprecated`
  - `Bluethooth` -> `Bluetooth`
  - `Temparature` -> `Temperature`
  - `Critcally` -> `Critically`
  - `SPG30` -> `SGP30`
  - `BMP280` -> `BME280`
- Reworded active package disclaimers from `Use at your own risks!` to
  `Use at your own risk.`
- Updated stale usage examples that still pointed at old `common/...`,
  `board/...`, or `sensors/digital/...` paths.
- Removed duplicate bare WiFi reference URLs already covered by normalized
  `# Reference:` lines.
- Corrected the ESP32-C3 Super Mini board reference URL.

## Validation

- Generic YAML parsing passed across the repository.
- `git diff --check` passed.
- ESPHome `config` validation passed with a temporary scratch ESP32
  configuration including:
  - `sensors/analogue/tds_sensor.yaml`
  - `sensors/i2c/ltr390.yaml`
  - `sensors/i2c/sgp40.yaml`

## Needs Design Review

- Several board packages still pin framework `version: latest`. This matches the
  project goal of staying close to bleeding edge ESPHome behaviour, but it makes
  builds less reproducible.
- `boards/raspberry_pi/2040_pico_w.yaml` still uses `includes:` and
  `platform: custom` for Pico LED handling. This is isolated to the unfinished
  Pico package and should be revisited with Pico hardware context.
- `sensors/analogue/tds_sensor.yaml` depends on
  `${device_internal_name}_internal_temperature` for compensation. That works
  when paired with current board packages, but a future improvement would be to
  accept an explicit `temperature` variable like the SGP40 package.
- `sensors/i2c/sgp30.yaml` and `sensors/i2c/ens160.yaml` still use internal IDs
  containing `clasification`. Renaming those IDs would be a breaking change for
  any local YAML that references them.
