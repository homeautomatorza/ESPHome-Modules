# HAZA Weather Sense Wind Validation

This page records validation evidence for the wind-stage modular Weather Sense
project.

Weather Sense Wind starts from Weather Sense Basic and adds the historical
anemometer and wind-vane inputs.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Pass | Public recipe passed with ESPHome 2026.7.3; Desktop deployment revalidated with ESPHome 2026.8 beta on 2026-08-22. |
| Compile validation | Pass | Public recipe passed with ESPHome 2026.7.3; Desktop deployment revalidated with ESPHome 2026.8 beta on 2026-08-22. |
| Physical upload | Pass | Serial push passed on Pascal's weather-station hardware after the name change, then revalidated with ESPHome 2026.8 beta on 2026-08-22. |
| Live sensor values | Partial pass | Log check and ESPHome web server screenshot confirmed wind speed, Beaufort, and one wind direction value. The light package has been corrected from BH1750 to LTR390 after Pascal confirmed the board uses I2C address `0x53`. |
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

## Automated Validation

Commands run:

- `.venv/bin/esphome config recipes/projects/weather_sense/wind/esphome_weather_sense_wind_project.yaml`
- `.venv/bin/esphome compile recipes/projects/weather_sense/wind/esphome_weather_sense_wind_project.yaml`

Result:

- Config: pass.
- Compile: pass.
- Firmware image size: 1,091,119 bytes.
- RAM: 28.0%.
- Flash: 59.5%.
- Smallest app partition remaining: 41%.

Warnings:

- GPIO2 is a strapping pin. This matches the historical status LED pin, but the
  hardware must not pull the pin into a bad boot state.

## Physical Validation

Pascal's 2026-08-22 hardware test, revalidated that morning with ESPHome 2026.8
beta:

- Compile: pass.
- Serial push: pass.
- Log check: pass, log attached in the working thread.
- ESPHome web server check: pass, screenshot supplied in the working thread.
- Screenshot evidence:
  - Wind Speed (KPH) published a live value.
  - Wind Speed (Knots) published a live value.
  - Beaufort Wind Scale published `Calm`.
  - Wind Cardinal Direction published `W`.
  - Wind Heading published `270.0°`.
  - ADC wind and Resistance Sensor published live values.
  - Light sensing previously showed `NA` because the build used the wrong
    BH1750 package for this board.
- Correction: this board uses LTR390 at I2C address `0x53`, not BH1750 at
  `0x23`.
- Web-server cleanup noted during review:
  - Wind Cardinal Direction was missing an icon.
  - Wind Heading was missing an icon.
  - BME280 Atmospheric Pressure RAW was missing an icon.
  - ADC wind was missing an icon.

Follow-up checks still needed:

- Confirm Wind Heading changes across multiple vane positions.
- Confirm Wind Cardinal Direction matches each tested vane position.
- Recompile and recheck the corrected LTR390 entities on the real hardware.

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
- `sensors/analogue/sparkfun_anemometer.yaml`
- `sensors/analogue/sparkfun_wind_vane.yaml`
- Local ADC block for battery voltage and percentage

## Remaining Documentation Evidence

Still to add or approve:

- Local copy of the Weather Sense Wind web-server screenshot asset.
- Home Assistant device screenshot.
- Wind direction test screenshot or notes for more than one vane position.
- Fritzing wiring diagram.
- BOM component photos.
- Battery voltage calibration notes.
- LTR390 value screenshot or log check after the corrected package is uploaded.
- Pascal documentation approval.
