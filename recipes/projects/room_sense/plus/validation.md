# HAZA Room Sense Plus Validation

This page records validation evidence for the Room Sense Plus project.

Room Sense Plus starts from the hardware-validated Room Sense Basic package
stack and adds the ENS160 VOC, eCO2, and air quality sensor. The ENS160 path
has been physically checked on a private validation device, but still needs
final screenshots and documentation approval.

An SGP30 alternate is also available. It uses the validated Room Sense Air Stage
2 stack: ESP32-C6 Super Mini, BME280, BH1750, and SGP30.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | ESPHome `2026.7.3` accepted the recipe YAML. |
| Compile validation | Passed | ESPHome `2026.7.3` produced firmware; Pascal also reported local compile pass on `2026-08-16`. |
| Physical upload | Passed | Pascal reported OTA upload passed on `2026-08-16`. |
| Live sensor values | Passed | Pascal reported web visual confirmation passed on `2026-08-16`; screenshots still need to be captured for documentation. |
| SGP30 alternate | Passed | ESP32-C6, BME280, BH1750, and SGP30 config, compile, OTA, web access, and live values passed on `2026-08-17`. Public alternate recipe compile hash: `0x743ada86`. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Package Stack Under Test

This project validates the Basic stack plus ENS160:

- `boards/esp32/c3_super_mini.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bh1750.yaml`
- `sensors/i2c/aht2x_3x.yaml`
- `sensors/i2c/ens160.yaml`

The verified SGP30 alternate validates:

- `boards/esp32/c6_super_mini.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bh1750.yaml`
- `sensors/i2c/bme280.yaml`
- `sensors/i2c/sgp30.yaml`

## Automated Validation

Local recipe file:

```text
recipes/projects/room_sense/plus/esphome_room_sense_plus_project.yaml
recipes/projects/room_sense/plus/esphome_room_sense_plus_project_alternate.yaml
```

Validated with:

```text
ESPHome 2026.7.3
```

Results:

- Config validation passed.
- Compile validation passed.
- Local validation-device compile passed, reported by Pascal on `2026-08-16`.
- ENS160 text-sensor fixes config and compile validated on ESPHome `2026.7.3`
  on `2026-08-16`; Pascal reported OTA upload and web visual confirmation
  passed.
- SGP30 alternate config and compile passed on ESPHome `2026.7.3` on
  `2026-08-17`.
- SGP30 alternate public recipe compile used `33.3%` RAM and `65.3%` flash.
- Known board note: GPIO9 is a strapping pin on the ESP32-C3 Super Mini.
- SGP30 alternate known board note: GPIO8 is a strapping pin on the ESP32-C6
  Super Mini.

## Physical Validation

Physical test device:

```text
Private Room Sense Plus validation deployment
```

Reported result:

- Compile passed.
- OTA upload passed.
- Web visual confirmation passed.
- Initial waiting-for-data state should use the standard `Waiting For Data`
  label rather than a blank value.
- ESPHome web server screenshot pending for documentation.
- Home Assistant device screenshot pending.

SGP30 alternate reported result:

- Config passed.
- Compile passed.
- OTA upload passed.
- ESPHome web access worked as expected.
- SGP30 eCO2 and TVOC values behaved as expected.

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web server and Home Assistant screenshots for the Plus build.
  Reminder for Pascal: capture these after the successful serial upload and
  first visual value check.
- Fritzing wiring diagram with ENS160 added.
- Final wiring table confirmation against the physical build.
- BOM component photos, including ENS160.
- Pascal documentation approval.
