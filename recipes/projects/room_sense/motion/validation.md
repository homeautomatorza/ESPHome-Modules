# HAZA Room Sense Motion Validation

This page records validation evidence for the staged Room Sense Motion project.

Room Sense Motion starts with an ESP32-C6 Super Mini, BH1750, BME280, and an
HC-SR501 PIR movement sensor. A C3 version is likely a better long-term fit, but
the first validation target is the already wired C6 Study device.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | Public recipe and local Study build passed config validation with ESPHome 2026.7.3. |
| Compile validation | Passed | Public recipe and local Study build compiled successfully on 2026-08-17. |
| Physical upload | Passed | Serial push succeeded on the Room Sense Motion validation device after the name change. |
| Live sensor values | Passed | Logs and ESPHome web server confirmed BME280, BH1750, WiFi diagnostics, and HC-SR501 movement on/off states. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Automated Validation

Public recipe:

- Config command: `.venv/bin/esphome config recipes/projects/room_sense/motion/esphome_room_sense_motion_project.yaml`
- Compile command: `.venv/bin/esphome compile recipes/projects/room_sense/motion/esphome_room_sense_motion_project.yaml`
- ESPHome version: `2026.7.3`
- Compile result: pass
- RAM: 33.3% (`150562` bytes from `452112`)
- Flash: 65.0% (`1192932` bytes from `1835008`)
- Config hash: `0xb6e2d6fc`
- Build time: `2026-08-17 18:17:22 +0200`

Local Study validation file:

- Config command: `.venv/bin/esphome config study-sense-motion.yaml`
- Compile command: `.venv/bin/esphome compile study-sense-motion.yaml`
- ESPHome version: `2026.7.3`
- Compile result: pass
- RAM: 33.3% (`150562` bytes from `452112`)
- Flash: 65.0% (`1192932` bytes from `1835008`)
- Config hash: `0x0f480da5`
- Build time: `2026-08-17 18:19:21 +0200`

Known warning:

- ESPHome warns that the C6 board package uses GPIO8 as a strapping pin for the
  onboard RGB LED. This warning comes from the board package, not the PIR
  wiring.

## Physical Validation

Passed on 2026-08-17.

Evidence supplied by Pascal:

- Compile: pass
- Serial push: pass
- Log check: pass
- Web check: pass
- Screenshot evidence: ESPHome web server showed `HC-SR501 Movement` detected
  and not detected.
- Log evidence: ESPHome `2026.7.4`, project `haza.room_sense_motion`, ESP32-C6,
  `HC-SR501 Movement` on `GPIO1`, and web/WiFi connectivity on the private
  validation network.

Expected checks:

- ESPHome compile succeeds. Passed.
- First upload succeeds. Passed by serial push because the device name changed.
- ESPHome logs show the C6, BH1750, BME280, and HC-SR501 entities without
  reported errors. Passed.
- ESPHome web server shows the BME280 and BH1750 values. Passed.
- ESPHome web server shows `HC-SR501 Movement`. Passed.
- The PIR changes state when movement is tested in front of the sensor. Passed.

## Package Stack Under Test

- `boards/esp32/c6_super_mini.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bh1750.yaml`
- `sensors/i2c/bme280.yaml`
- `sensors/binary/hc_sr501.yaml`

## Remaining Documentation Evidence

Still to add or approve:

- Config and compile output.
- ESPHome web server screenshot asset files.
- Home Assistant device screenshot.
- Fritzing wiring diagram.
- BOM component photos, including HC-SR501.
- Pascal documentation approval.
