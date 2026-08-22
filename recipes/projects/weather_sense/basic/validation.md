# HAZA Weather Sense Basic Validation

This page records validation evidence for the first modular Weather Sense
project.

Weather Sense Basic starts from Pascal's older flat weather station YAML and
keeps only the static baseline: ESP32 DevKit style board, BME280, DS18B20,
LTR390 UV/light, battery voltage, and sun helpers.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Pass | Public recipe passed with ESPHome 2026.7.3; Desktop deployment revalidated with ESPHome 2026.8 beta on 2026-08-22. |
| Compile validation | Pass | Public recipe passed with ESPHome 2026.7.3; Desktop deployment revalidated with ESPHome 2026.8 beta on 2026-08-22. |
| Physical upload | Pass | Serial push passed after the Desktop upload file name change, then revalidated with ESPHome 2026.8 beta on 2026-08-22. |
| Live sensor values | Partial pass | Logs and web server confirmed the device, BME280 values, DS18B20 temperature, WiFi diagnostics, uptime, and battery ADC. The light package has been corrected from BH1750 to LTR390 after Pascal confirmed the board uses I2C address `0x53`. |
| Documentation approval | Pending | Draft documentation still needs Pascal review. |

## Source Evidence

Historical source:

- Pascal's older flat weather station YAML, retained as private source material.

Public hardware reference:

- Open Green Energy Solar Powered WiFi Weather Station V3.0

The Open Green Energy project is the hardware base for this station. The
original project provides C++ firmware. Pascal converted the build to ESPHome
for his own station, and this recipe is the staged HAZA modular rebuild of that
older flat ESPHome file.

The reference hardware uses an ESP32 weather station board with BME280,
DS18B20, LTR390 UV/light, wind, rain, solar charging, and battery monitoring. This
Basic recipe intentionally uses the dedicated
`boards/esp32/haza_weather_station_v1.yaml` package for Pascal's converted
station hardware. The Open Green Energy board package will be reviewed later as
its own hardware target.

## Automated Validation

Commands run:

- `.venv/bin/esphome config recipes/projects/weather_sense/basic/esphome_weather_sense_basic_project.yaml`
- `.venv/bin/esphome compile recipes/projects/weather_sense/basic/esphome_weather_sense_basic_project.yaml`

Result:

- Config: pass.
- Compile: pass.
- Firmware image size: 1,078,715 bytes.
- RAM: 27.1%.
- Flash: 58.8%.
- Smallest app partition remaining: 41%.

Warnings:

- GPIO2 is a strapping pin. This matches the historical status LED pin, but the
  hardware must not pull the pin into a bad boot state.

## Physical Validation

Evidence supplied by Pascal on 2026-08-22 and revalidated that morning with
ESPHome 2026.8 beta:

- Compile: pass.
- Serial push: pass.
- Log check: pass.
- Web check: pass.
- ESPHome web server reachable at the device `.local` address.
- ESPHome web server uptime reached at least 18 minutes in the supplied
  screenshot.
- BME280 temperature, humidity, atmospheric pressure, and dew point were visible
  on the ESPHome web server.
- DS18B20 reported temperature in the logs and on the ESPHome web server.
- WiFi diagnostics showed IP address, connected SSID, and signal strength.
- Battery ADC entities appeared on the ESPHome web server.

Follow-up before calling every Basic sensor fully validated:

- Recompile and recheck the corrected LTR390 entities on the real hardware.
- Battery voltage was visible but read very low, so the voltage divider and
  battery calibration still need to be checked against a multimeter.
- Home Assistant device screenshot still needs to be captured for the project
  documentation set.

## Package Stack Under Test

- `boards/esp32/haza_weather_station_v1.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/core/sun.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bme280.yaml`
- `sensors/one_wire/ds18b20.yaml`
- `sensors/i2c/ltr390.yaml`
- Local ADC block for battery voltage and percentage

## Remaining Documentation Evidence

Still to add or approve:

- ESPHome web server screenshot asset from the 2026-08-22 serial validation.
- Home Assistant device screenshot.
- Fritzing wiring diagram.
- BOM component photos.
- Battery voltage calibration notes.
- LTR390 value screenshot or log check after the corrected package is uploaded.
- Pascal documentation approval.
