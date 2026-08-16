# HAZA Room Sense Air Validation

This page records validation evidence for the staged Room Sense Air project.

Room Sense Air is being brought up one sensor at a time. The current stage uses
the ESP32-C6 Super Mini, BH1750, and BME280 only.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | ESPHome `2026.7.3` accepted the staged recipe YAML. |
| Compile validation | Passed | ESPHome `2026.7.3` produced C6 firmware. |
| Physical upload | Pending | Needs upload to the C6 validation device. |
| Live sensor values | Pending | Needs ESPHome web server and Home Assistant value checks. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Automated Validation

Validated with:

```text
ESPHome 2026.7.3
```

Results:

- Config validation passed.
- Compile validation passed.
- Known board note: GPIO8 is a strapping pin on the ESP32-C6 Super Mini.

## Package Stack Under Test

- `boards/esp32/c6_super_mini.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bh1750.yaml`
- `sensors/i2c/bme280.yaml`

## Staged Additions

| Stage | Package | Status |
| --- | --- | --- |
| SGP30 | `sensors/i2c/sgp30.yaml` | Planned next |
| SPS30 | `sensors/i2c/sps30.yaml` | Planned |
| PIR | `sensors/binary/hc_sr501.yaml` | Planned |
| LD2410C | `sensors/uart/hlk_ld2410c_minimal.yaml` | Planned |

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web server screenshot.
- Home Assistant device screenshot.
- Fritzing wiring diagram.
- BOM component photos, including BME280.
- Pascal documentation approval.
