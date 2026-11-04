# HAZA Room Sense Basic Validation

This page records validation evidence for the Room Sense Basic project.

Config and compile checks matter, but they are not physical hardware tests.

## Maintenance Boundary

Pascal marked Room Sense Basic complete and frozen for feature work on
2026-11-04. Future ESPHome validation checks and their results may be recorded
here. Changes to hardware, wiring, features or firmware behaviour require Pascal
to reopen the project explicitly. Documentation approval does not extend the
historical hardware test to later ESPHome versions.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | ESPHome `2026.7.3` accepted the recipe YAML. |
| Compile validation | Passed | ESPHome `2026.7.3` produced firmware. |
| Physical upload | Passed | `Room Sense Basic validation device`, 2026-08-02. |
| BH1750 code revalidation | Passed | Human-readable illuminance label update compiled and was reinstalled successfully by OTA, 2026-08-16. |
| Wi-Fi signal label review | Passed | Human-readable RSSI label update compiled, OTA installed, and returned expected values, 2026-08-16. |
| Live sensor values | Passed | ESPHome web server and Home Assistant showed expected values without reported errors. |
| Documentation approval | Approved | Approved by Pascal on 2026-11-04 after supplying the corrected Fritzing diagram. Publication also approved by Pascal. |

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
recipes/projects/room_sense/basic/esphome_room_sense_basic_project.yaml
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
- Wi-Fi signal-strength label update was reinstalled successfully by OTA and returned expected values on 2026-08-16.
- The device returned expected values.
- ESPHome web server showed values without reported errors.
- Home Assistant device page showed expected entities without reported errors.

Supporting screenshots:

- [ESPHome web server view](../assets/device-web-server.png)
- [Home Assistant device view](../assets/home-assistant-device.png)

## Documentation Evidence And Approval

Status confirmed by Pascal during documentation review:

- Updated ESPHome web server and Home Assistant screenshots: complete.
- Fritzing wiring diagram: corrected version supplied by Pascal and replaced
  with a transparent PNG on 2026-11-04. Exterior wire gaps and logo edges were
  cleaned with a pixel mask; breadboard, components and internal wiring pixels
  were preserved. Sensor power is labelled
  3.3 V; the unused upper rail is labelled 5 V.
- Final wiring table confirmation against the physical build: complete,
  confirmed by Pascal.
- BOM component photos: complete.
- Final device or installed-location photo: omitted; the build was dismantled
  and this optional photo is not required.
- Documentation approval: documentation and publication approved by Pascal on
  2026-11-04. This approval does not record a new firmware or hardware test.
