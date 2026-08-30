# HAZA Room Sense Max Validation

This page records validation evidence for the combined Room Sense Max project.

Room Sense Max combines the hardware-validated Air and Presence stages:
ESP32-C6 Super Mini, BH1750, BME280, SGP30, SPS30, HC-SR501 PIR, HLK-LD2410C,
and a combined `Room Occupancy` binary sensor.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | Public recipe and local Desktop App file passed ESPHome 2026.7.3 config checks on 2026-08-17. |
| Compile validation | Passed | Public recipe and local Desktop App file compiled with ESPHome 2026.7.3 on 2026-08-17; hardware validation compile used ESPHome 2026.7.4. |
| Physical upload | Passed | Serial push and OTA upload passed on the private Room Sense Max validation device on 2026-08-17. |
| Live sensor values | Passed | Web/log confirmation passed for BH1750, BME280, SGP30, SPS30, HC-SR501, LD2410C GPIO presence, and `Room Occupancy`. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Inherited Evidence

These project stages were validated before Max was assembled:

- Room Sense Air validated the ESP32-C6, BH1750, BME280, SGP30, and SPS30 stack
  on the private validation device.
- Room Sense Motion validated the ESP32-C6, BH1750, BME280, and HC-SR501 PIR
  stack on the private validation device.
- Room Sense Presence validated the ESP32-C6, BH1750, BME280, HC-SR501 PIR,
  HLK-LD2410C, and combined `Room Occupancy` stack on the private validation
  device.

That inherited evidence is useful, but Max still needed its own combined
validation because the full sensor stack changes memory use, entity count,
startup timing, I2C load, and runtime behaviour. That combined validation passed
on `2026-08-17`.

## Automated Validation

Passed on `2026-08-17`.

Public recipe commands:

- `.venv/bin/esphome config recipes/projects/room_sense/max/esphome_room_sense_max_project.yaml`
- `.venv/bin/esphome compile recipes/projects/room_sense/max/esphome_room_sense_max_project.yaml`

Public recipe compile evidence:

- ESPHome: `2026.7.3`
- RAM: `33.9%`, `153356` bytes used from `452112`
- Flash: `67.1%`, `1231048` bytes used from `1835008`
- Firmware artifacts: `firmware.factory.bin`, `firmware.ota.bin`,
  `firmware.elf`
- Config hash: `0xdaa89b5a`
- Build time: `2026-08-17 18:58:45 +0200`

Local Desktop App validation file:

- Private ESPHome Desktop App validation file for the Max device.

Local Desktop App validation passed with ESPHome `2026.7.3` after refreshing
the Home Automator ZA GitHub package includes.

Local Desktop App compile evidence:

- ESPHome: `2026.7.3`
- RAM: `33.9%`, `153356` bytes used from `452112`
- Flash: `67.1%`, `1231048` bytes used from `1835008`
- Firmware artifacts: `firmware.factory.bin`, `firmware.ota.bin`,
  `firmware.elf`
- Config hash: `0xa5de4840`
- Build time: `2026-08-17 19:01:54 +0200`

Known warnings:

- ESPHome warns that the C6 board package uses GPIO8 as a strapping pin for the
  onboard RGB LED.
- ESPHome warns that GPIO4 is a strapping pin. In this staged validation build,
  GPIO4 is used as ESP32-C6 UART RX for the LD2410C, following the previous
  validation wiring pattern.

## Physical Validation

Passed on `2026-08-17`.

Pascal's validation evidence:

- Compile: passed with ESPHome `2026.7.4`.
- Upload: serial push passed. Serial upload was expected because the local
  validation device name changed for this stage.
- OTA: passed after the successful serial deployment, proving the normal update
  path as well as the name-change recovery path.
- Log check: passed.
- Web check: passed.
- Build timestamp from the attached validation log: `2026-08-17 19:07:41 +0200`.
- The attached log reported project `haza.room_sense_max` version `2026.0.0b`
  because the firmware was built before this validation promotion changed the
  project metadata to `2026.0.0`.

Runtime evidence observed:

- ESP32-C6 started successfully.
- I2C scan found the expected devices at `0x23`, `0x58`, `0x69`, and `0x76`.
- UART for the LD2410C started on TX `GPIO3`, RX `GPIO4`, baud `256000`,
  parity `NONE`, and `1` stop bit.
- ESPHome web server showed live values for BH1750, BME280, SGP30, SPS30,
  HC-SR501 movement, LD2410C GPIO presence, and `Room Occupancy`.
- SGP30 eCO2 classification and TVOC level updated from real sensor values.
- SGP30 compensation received BME280 humidity and temperature data.
- SPS30 measurement started, fan auto-clean started, and particulate values
  appeared in the web server view after warm-up.
- `Room Occupancy` showed true when LD2410C GPIO presence was true.

Non-blocking observations:

- One SGP30 timing warning was observed: the SGP30 operation took `63 ms`
  against ESPHome's `50 ms` warning threshold. The sensor continued updating
  and the combined log/web validation still passed.

Optional evidence when practical:

- `Room Occupancy` false with no PIR movement and no LD2410C presence.
- Home Assistant device page screenshot after the entity set has settled.

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
- `sensors/binary/hc_sr501.yaml`
- `sensors/uart/hlk_ld2410c_minimal.yaml`
- Local UART block: TX `GPIO3`, RX `GPIO4`, baud `256000`

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web server screenshot asset files. Pascal captured the first Max web
  screenshot in chat on `2026-08-17`; it still needs to be added to `assets/`.
- Home Assistant device screenshot.
- Fritzing wiring diagram.
- BOM component photos for the full Max stack.
- Optional no-presence screenshot or log evidence when it is practical to
  capture from outside the detection area.
- Pascal documentation approval.
