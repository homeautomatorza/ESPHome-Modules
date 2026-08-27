# HAZA Room Sense Presence Validation

This page records validation evidence for the staged Room Sense Presence project.

Room Sense Presence starts from the hardware-validated Motion baseline:
ESP32-C6 Super Mini, BH1750, BME280, and HC-SR501 PIR movement. This project
adds the HLK-LD2410C mmWave presence sensor and a combined `Room Occupancy`
binary sensor.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | Public recipe and local Desktop App file passed ESPHome 2026.7.3 config checks on 2026-08-17. |
| Compile validation | Passed | Public recipe compiled with ESPHome 2026.7.3; Pascal also compiled the local Desktop App build with ESPHome 2026.7.4 on 2026-08-17. |
| Physical upload | Passed | Serial push passed on the private Presence validation device on 2026-08-17. |
| Live sensor values | Passed with caveat | Log and web checks passed; LD2410C GPIO presence and `Room Occupancy` were observed true. No-presence was not captured because the radar was tested in an occupied room. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Automated Validation

Passed on `2026-08-17`.

Public recipe commands:

- `.venv/bin/esphome config recipes/projects/room_sense/presence/esphome_room_sense_presence_project.yaml`
- `.venv/bin/esphome compile recipes/projects/room_sense/presence/esphome_room_sense_presence_project.yaml`

Public recipe compile evidence:

- ESPHome: `2026.7.3`
- RAM: `33.6%`, `152068` bytes used from `452112`
- Flash: `66.2%`, `1215428` bytes used from `1835008`
- Firmware artifacts: `firmware.factory.bin`, `firmware.ota.bin`,
  `firmware.elf`
- Config hash: `0x016ebb76`
- Build time: `2026-08-17 18:42:35 +0200`

Local Desktop App validation file:

- Private ESPHome Desktop App validation file for the Presence device.

Local Desktop App compile evidence:

- ESPHome: `2026.7.3`
- RAM: `33.6%`, `152068` bytes used from `452112`
- Flash: `66.2%`, `1215444` bytes used from `1835008`
- Firmware artifacts: `firmware.factory.bin`, `firmware.ota.bin`,
  `firmware.elf`
- Config hash: `0x998296fb`
- Build time: `2026-08-17 18:43:20 +0200`

Pascal's physical validation compile and serial push used ESPHome `2026.7.4`.
The attached serial log reports project `haza.room_sense_presence` version
`2026.0.0b`, compiled on `2026-08-17 18:46:46 +0200`.

Known warnings:

- ESPHome warns that the C6 board package uses GPIO8 as a strapping pin for the
  onboard RGB LED. This warning comes from the board package, not the PIR
  wiring.
- ESPHome warns that GPIO4 is a strapping pin. In this staged validation build,
  GPIO4 is used as ESP32-C6 UART RX for the LD2410C, following the previous
  Study wiring pattern.

## Baseline Evidence

Room Sense Motion passed on `2026-08-17` with the same ESP32-C6, BH1750, BME280,
and HC-SR501 PIR baseline. That validates the inherited movement stack, but it
does not validate LD2410C presence.

## Physical Validation

Passed on `2026-08-17` on the private Presence validation device.

Observed checks:

- Compile passed.
- Serial push passed. Serial upload was used because the device name changed
  from Motion to Presence.
- Log check passed with ESPHome `2026.7.4`.
- Web check passed.
- ESPHome logs show the C6, BH1750, BME280, HC-SR501, UART, and LD2410C
  components without reported setup errors.
- UART is configured at TX `GPIO3`, RX `GPIO4`, baud `256000`, parity `NONE`,
  and `1` stop bit.
- LD2410C setup completed and exposed `LD2410 Presence`, `LD2410 Moving
  Target`, `LD2410 Still Target`, distance, energy, firmware, select, switch,
  and button entities.
- ESPHome web server showed BME280 values, BH1750 illuminance, `HC-SR501
  Movement`, `LD2410 GPIO Presence`, and `Room Occupancy`.
- `LD2410 GPIO Presence` was observed true.
- `Room Occupancy` was observed true when presence was detected.

Not captured in this evidence set:

- `Room Occupancy` false with no PIR movement and no LD2410C presence. Because
  LD2410C is radar-based, Pascal could not practically capture no-presence from
  inside the same room during this quick validation pass.

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
- `sensors/uart/hlk_ld2410c_minimal.yaml`
- Local UART block: TX `GPIO3`, RX `GPIO4`, baud `256000`

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web server screenshot asset files.
- Home Assistant device screenshot.
- Fritzing wiring diagram.
- BOM component photos, including HC-SR501 and HLK-LD2410C.
- Optional no-presence screenshot or log evidence when it is practical to
  capture from outside the detection area.
- Pascal documentation approval.
