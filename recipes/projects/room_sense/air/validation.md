# HAZA Room Sense Air Validation

This page records validation evidence for the staged Room Sense Air project.

Room Sense Air is being brought up one sensor at a time. Stage 1 used the
ESP32-C6 Super Mini, BH1750, and BME280. Stage 2 added SGP30 eCO2 and TVOC.
Stage 3 adds SPS30 particulate matter.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | ESPHome `2026.7.3` accepted the staged recipe YAML. |
| Compile validation | Passed | ESPHome `2026.7.3` produced C6 firmware; cleaned shared-default build compiled on `2026-08-17`. |
| Physical upload | Passed | Pascal flashed the Stage 3 SPS30 build to a replacement ESP32-C6 validation board on `2026-08-17`; OTA passed. |
| Live sensor values | Passed | ESPHome web server and logs showed live BH1750, BME280, SGP30, and SPS30 values without reported errors. |
| SGP30 stage | Reported working | SGP30 package added with BME280 compensation; config and compile passed on `2026-08-17`, and Pascal reported the stage working as expected on private hardware. |
| SPS30 stage | Passed | SPS30 package added on I2C address `0x69`; compile, OTA, log, and web checks passed on `2026-08-17`. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Automated Validation

Validated with:

```text
ESPHome 2026.7.3 for local config and compile checks.
ESPHome 2026.7.4 for Pascal's physical OTA, log, and web checks.
```

Results:

- Config validation passed.
- Compile validation passed.
- Cleaned shared-default compile passed on `2026-08-17`.
- SGP30 Stage 2 config and compile passed on `2026-08-17`.
- SPS30 Stage 3 live device config and compile passed on `2026-08-17`.
- SPS30 Stage 3 public recipe config and compile passed on `2026-08-17`.
- Pascal reported Stage 3 compile, OTA, log, and web checks passed with ESPHome
  `2026.7.4` on `2026-08-17`.
- Known board note: GPIO8 is a strapping pin on the ESP32-C6 Super Mini.

Compile details after adding SPS30:

| Target | RAM | Flash | Config Hash |
| --- | --- | --- | --- |
| Live validation device | `33.5%` (`151548` of `452112` bytes) | `65.7%` (`1204980` of `1835008` bytes) | `0x89c7f60c` |
| Public recipe | `33.5%` (`151548` of `452112` bytes) | `65.7%` (`1204964` of `1835008` bytes) | `0x49bd90e5` |

## Physical Validation

Stages 1 through 3 were physically checked by Pascal on `2026-08-17` using a
private validation device.

Evidence observed:

- The first ESP32-C6 board showed web/API reachability problems and is now
  treated as a suspect board for later investigation.
- After replacing the ESP32-C6 board, the same staged project came online.
- The ESPHome web server loaded successfully.
- The local bring-up overrides were removed from the validation device YAML.
- The cleaned YAML restored the shared framework defaults for Wi-Fi, logger,
  and authenticated web server configuration.
- OTA upload of the cleaned shared-default build passed.
- Authenticated ESPHome web server access worked as expected.
- The Stage 1 web server check showed live values for:
  - `BH1750 Illuminance`
  - `BH1750 Illuminance Human Readable`
  - `BME280 Temperature (C)`
  - `BME280 Humidity`
  - `BME280 Atmospheric Pressure`
  - `BME280 Dew Point`
  - `Uptime`
  - `IP Address`
  - `Connected SSID`
  - `Wifi Signal Strength`

Stage 2 added SGP30 eCO2 and TVOC sensing with BME280 temperature and humidity
compensation. Pascal reported this stage working as expected on the private
validation device. Screenshot evidence still needs to be collected for the
project docs.

Stage 3 added SPS30 particulate matter sensing on I2C address `0x69`. Pascal
reported compile, OTA, log, and ESPHome web checks passed. The attached log
showed the I2C scan finding `0x23`, `0x58`, `0x69`, and `0x76`, and confirmed
the SPS30 component at `0x69`. The ESPHome web server showed live SPS30
particulate values, including:

- `SPS30 PM <1um Weight concentration`
- `SPS30 PM <2.5um Weight concentration`
- `SPS30 PM <4um Weight concentration`
- `SPS30 PM <10um Weight concentration`
- `SPS30 Fan Clean`

This validates the current Air stack: ESP32-C6 Super Mini, BH1750, BME280,
SGP30, SPS30, shared Wi-Fi, web server, OTA, API, uptime, and diagnostic
packages as used by this project stage.

The earlier board remains excluded from this validation result. It is treated as
a suspect hardware unit until separately investigated.

## Package Stack Under Test

- `boards/esp32/c6_super_mini.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bh1750.yaml`
- `sensors/i2c/bme280.yaml`
- `sensors/i2c/sgp30.yaml`
- `sensors/i2c/sps30.yaml`

## Staged Additions

| Stage | Package | Status |
| --- | --- | --- |
| SGP30 | `sensors/i2c/sgp30.yaml` | Config and compile passed; reported working on private hardware |
| SPS30 | `sensors/i2c/sps30.yaml` | Compile, OTA, log, and web checks passed |
| PIR | `sensors/binary/hc_sr501.yaml` | Planned |
| LD2410C | `sensors/uart/hlk_ld2410c_minimal.yaml` | Planned |

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web server screenshot asset file.
- Home Assistant device screenshot.
- Fritzing wiring diagram.
- BOM component photos, including BME280.
- Pascal documentation approval.
