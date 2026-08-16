# HAZA Room Sense Plus Validation

This page records validation evidence for the Room Sense Plus project.

Room Sense Plus starts from the hardware-validated Room Sense Basic package
stack and adds the ENS160 VOC, eCO2, and air quality sensor. That new package
changes the hardware stack, so Plus must stay in beta until the ENS160 build is
physically tested.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | ESPHome `2026.7.3` accepted the recipe YAML. |
| Compile validation | Passed | ESPHome `2026.7.3` produced firmware. |
| Physical upload | Pending | Needs OTA or serial install on a real Room Sense Plus device. |
| Live sensor values | Pending | Needs ESPHome web server and Home Assistant value checks. |
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

## Automated Validation

Local recipe file:

```text
recipes/projects/room_sense/plus/esphome_room_sense_plus_project.yaml
```

Validated with:

```text
ESPHome 2026.7.3
```

Results:

- Config validation passed.
- Compile validation passed.
- Known board note: GPIO9 is a strapping pin on the ESP32-C3 Super Mini.

## Physical Validation

Physical test device:

```text
Pending
```

Reported result:

- Firmware upload pending.
- ENS160 eCO2, TVOC, and air quality values pending.
- ESPHome web server screenshot pending.
- Home Assistant device screenshot pending.

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web server and Home Assistant screenshots for the Plus build.
- Fritzing wiring diagram with ENS160 added.
- Final wiring table confirmation against the physical build.
- BOM component photos, including ENS160.
- Pascal documentation approval.
