# HAZA Room Sense Basic Validation

This page records validation evidence for the Room Sense Basic project.

Automated config and compile checks are useful, but they are not the same thing
as a physical hardware test.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | ESPHome `2026.7.3` accepted the recipe YAML. |
| Compile validation | Passed | ESPHome `2026.7.3` produced firmware. |
| Physical upload | Passed | `Guest Room Sense Basic`, 2026-08-02. |
| Live sensor values | Passed | ESPHome web server and Home Assistant showed expected values without reported errors. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Validated Package Stack

The hardware pass validates this package stack for the Room Sense Basic build:

- `boards/esp32/c3_super_mini.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_fixedip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bh1750.yaml`
- `sensors/i2c/aht2x_3x.yaml`

The public recipe also includes `common/network/wifi_dynamicip.yaml`. That path
config-validates and compile-validates, but the first physical Guest Room
deployment used fixed IP.

## Automated Validation

Local recipe file:

```text
recipes/projects/room_sense_basic/esphome_room_sense_basic_project.yaml
```

Validated with:

```text
ESPHome 2026.7.3
```

Results:

- Config validation passed.
- Compile validation passed.
- Known warning: GPIO9 is a strapping pin on the ESP32-C3 Super Mini.

## Physical Validation

Physical test device:

```text
Guest Room Sense Basic
```

Date:

```text
2026-08-02
```

Reported result:

- Compile passed on the ESPHome beta server.
- Firmware upload succeeded.
- The device returned expected values.
- ESPHome web server showed values without reported errors.
- Home Assistant device page showed expected entities without reported errors.

Supporting screenshots:

- [ESPHome web server view](assets/device-web-server.png)
- [Home Assistant device view](assets/home-assistant-device.png)

## Remaining Documentation Evidence

Still to add or approve:

- Fritzing wiring diagram.
- Final wiring table confirmation against the physical build.
- BOM component photos.
- Final device or installed-location photo, if useful.
- Pascal documentation approval.

