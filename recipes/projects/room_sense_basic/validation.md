# HAZA Room Sense Basic Validation

This page records validation evidence for the Room Sense Basic project.

Config and compile checks matter, but they are not physical hardware tests.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | ESPHome `2026.7.3` accepted the recipe YAML. |
| Compile validation | Passed | ESPHome `2026.7.3` produced firmware. |
| Physical upload | Passed | `Room Sense Basic validation device`, 2026-08-02. |
| BH1750 code revalidation | Passed | Human-readable illuminance label update compiled and was reinstalled successfully by OTA, 2026-08-16. |
| Wi-Fi signal label review | Compile passed | Human-readable RSSI label update reviewed against common Wi-Fi guidance and compile-validated, 2026-08-16. OTA revalidation pending. |
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
config-validates and compile-validates, but the first physical validation
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
- Wi-Fi signal-strength human-readable label update config-validated and compile-validated on 2026-08-16.
- Known warning: GPIO9 is a strapping pin on the ESP32-C3 Super Mini.

## Physical Validation

Physical test device:

```text
Room Sense Basic validation device
```

Date:

```text
2026-08-02
```

Reported result:

- Compile passed on the ESPHome beta server.
- Firmware upload succeeded.
- BH1750 human-readable illuminance label update was reinstalled successfully by OTA on 2026-08-16.
- Wi-Fi signal-strength label update still needs OTA revalidation on the physical device.
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
