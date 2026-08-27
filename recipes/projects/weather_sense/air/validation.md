# HAZA Weather Sense Air Validation

This page records validation evidence for the Air modular Weather Sense project.

Weather Sense Air starts from the Basic stage, keeps the LTR390 correction, and
adds CCS811 eCO2/TVOC sensing on the shared I2C bus.

Wind and rain are intentionally out of scope for this variant. They move to the
future V4 weather-meter path where the physical hardware can be tested properly.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Pass | Public recipe and Desktop upload file validated with ESPHome 2026.7.3 after the LTR390 readable UV update. Pascal revalidated the Desktop upload with ESPHome 2026.8.0 beta. Only the known GPIO2 strapping-pin warning appeared. |
| Compile validation | Pass | Public recipe compiled with ESPHome 2026.7.3. Firmware image reported 1,088,119 bytes, 59.3% flash, 28.2% RAM after the LTR390 UV exposure label. Desktop upload file also compiled, reporting 1,088,135 bytes, 59.3% flash, 28.2% RAM. Pascal's ESPHome 2026.8.0 beta compile passed. |
| Physical upload | Pass | Pascal completed a serial push after the device-name change on 2026-08-22. |
| Log check | Partial pass | Boot log passed for the device, WiFi, BME280 at `0x76`, LTR390 at `0x53`, DS18B20, SNTP, and web server. CCS811 was marked failed during setup and `0x5A` did not appear in the I2C scan. |
| ESPHome web check | Partial pass | Web UI confirmed BME280, DS18B20, battery, LTR390 illuminance, LTR390 UV index, and LTR390 UV exposure level. CCS811 entities were present but blank because the sensor failed setup. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Source Evidence

Historical source:

- Pascal's older flat weather station YAML, retained as private source material.

Public hardware reference:

- Open Green Energy Solar Powered WiFi Weather Station V3.0
- ESPHome CCS811 documentation for the air-quality sensor package
- ESPHome LTR390 documentation for UV and ambient light sensing

## Package Stack Under Test

- `boards/esp32/haza_weather_station_v1.yaml`
- `common/core/settings.yaml`
- `common/time/sntp.yaml`
- `common/core/sun.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bme280.yaml`
- `sensors/one_wire/ds18b20.yaml`
- `sensors/i2c/ltr390.yaml`
- `sensors/i2c/ccs811.yaml`
- Local ADC block for battery voltage and percentage

## Physical Validation Evidence

2026-08-22 ESPHome 2026.8.0 beta pass:

- Compile: pass.
- Upload: serial push pass after the device-name change.
- Log check: pass for boot and baseline device services.
- ESPHome web check: pass for visible baseline entities.
- I2C scan: `0x53` LTR390 and `0x76` BME280 found.
- 1-Wire scan: DS18B20 found at the expected address.
- SNTP: time synchronized using the configured ZA pool servers.
- LTR390 readable labels: `LTR390 Illuminance Human Readable` and
  `LTR390 UV Exposure Level` appeared in the web UI.
- CCS811 issue: ESPHome reported `ccs811.sensor was marked as failed`; I2C
  scan did not show `0x5A`.

## Physical Validation Plan

For Pascal's Air runtime pass, check:

- Recheck CCS811 wiring, power, and module address.
- I2C scan: expect `0x5A` for CCS811 once the hardware fault is fixed.
- Web UI: confirm CCS811 eCO2, TVOC, and human-readable text labels update
  with values after the sensor is detected.
- Logs: confirm CCS811 no longer reports setup failure.

Deferred:

- Whether CCS811 baseline handling needs a measured value after burn-in.
- Wind and rain hardware testing for the future V4 branch.

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web-server screenshot supplied by Pascal.
- Home Assistant device screenshot.
- I2C scan or log excerpt after CCS811 is fixed and detected.
- Fritzing wiring diagram.
- BOM component photos.
- CCS811 setup and baseline notes after the hardware fault is fixed.
- Pascal documentation approval.
