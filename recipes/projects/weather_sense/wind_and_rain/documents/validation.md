# HAZA Weather Sense Wind and Rain Validation

This page records validation evidence for the Wind and Rain modular Weather
Sense project.

Weather Sense Wind and Rain starts from the hardware-tested Wind stage and adds
the historical tipping-bucket rain gauge input on `GPIO25`.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Pass | Public recipe validated with ESPHome 2026.7.3; Desktop deployment config cache accepted by ESPHome 2026.8.0. |
| Compile validation | Pass | Public recipe compiled with ESPHome 2026.7.3; Pascal confirmed ESPHome 2026.8.0 compile pass from the Desktop App. |
| Physical upload | Pass | Pascal confirmed serial push pass after the Wind and Rain name change. |
| Log check | Pass with correction needed | ESPHome 2026.8.0 log shows successful boot and project version `2026.0.0b`; I2C scan showed `0x53`, matching LTR390. The previous BH1750 package was wrong for this board. |
| ESPHome web check | Pass | Pascal confirmed web check pass and supplied a screenshot showing `Rainfall Rate`, `Rainfall Rate Hourly`, and `Total Rainfall`. |
| Rain bucket hardware test | Deferred | Rainfall fields are visible, but Pascal cannot physically test the tipping-bucket hardware on this build. This will be tested with the V4 hardware branch. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Source Evidence

Historical source:

- Pascal's older flat weather station YAML, retained as private source material.

Public hardware reference:

- Open Green Energy Solar Powered WiFi Weather Station V3.0
- SparkFun Weather Meter rain gauge documentation for the `0.2794` mm per tip
  starting calibration.

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
- `sensors/analogue/sparkfun_anemometer.yaml`
- `sensors/analogue/sparkfun_wind_vane.yaml`
- `sensors/analogue/sparkfun_rain_gauge.yaml`
- Local ADC block for battery voltage and percentage

## Physical Validation Plan

Pascal's first Wind and Rain runtime pass recorded:

- Compile: pass on ESPHome 2026.8.0.
- Upload type: serial push, pass after the device name change.
- Log check: pass. The I2C scan showed `0x53`, so the light/UV package was
  corrected to LTR390.
- ESPHome web server check: pass.
- Web UI confirmed the new rain fields:
  - `Rainfall Rate`
  - `Rainfall Rate Hourly`
  - `Total Rainfall`

Deferred to the future V4 hardware branch:

- Whether the rain gauge publishes a value when the bucket is tipped manually.
- Whether `Total Rainfall` increments by roughly `0.279` mm per tip.
- Whether the rain values remain stable when the bucket is not moving.

Known follow-up:

- Recompile and recheck the corrected LTR390 entities on the real hardware.

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web-server screenshot supplied by Pascal; needs to be saved into
  `assets/` during documentation cleanup.
- Home Assistant device screenshot.
- Manual rain-tip screenshot or log excerpt.
- Fritzing wiring diagram.
- BOM component photos.
- Rain gauge calibration notes.
- Pascal documentation approval.
