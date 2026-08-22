# HAZA Weather Sense Basic

> [!WARNING]
> **Disclaimer:** This is the first modular pass of Pascal's older weather
> station. The hardware is based on the Open Green Energy Solar Powered WiFi
> Weather Station V3.0 project. Pascal converted the original C++ firmware idea
> to ESPHome for his own build, and this recipe is the first staged HAZA
> modularization of that older flat ESPHome file. The recipe still needs upload
> and live-value checks before we call it hardware validated.

`HAZA Weather Sense Basic` is the quiet starting point for the weather station:
the ESP32 station board, indoor-board weather readings, external temperature,
light level, battery voltage, and sun-position helpers.

No wind cups. No tipping bucket. No UV rabbit hole yet.

## Current Status

- YAML recipe: `esphome_weather_sense_basic_project.yaml`
- Board: `boards/esp32/haza_weather_station_v1.yaml`
- Current stage: Beta, first hardware upload validated
- Config validation: Pass, ESPHome 2026.7.3 and ESPHome 2026.8 beta
- Compile validation: Pass, ESPHome 2026.7.3 and ESPHome 2026.8 beta
- Physical validation: Serial push pass, revalidated with ESPHome 2026.8 beta
  on 2026-08-22
- Live validation: Partial pass, BME280 and DS18B20 confirmed; light/UV package
  corrected to LTR390 after the board was confirmed to use address `0x53`
- Documentation approval: Draft, pending Pascal review

Full validation notes live in [validation.md](validation.md).

## Why Build This?

Weather Sense Basic gets the old weather station breathing again without asking
every sensor to behave on day one.

The hardware base comes from the
[Open Green Energy Solar Powered WiFi Weather Station V3.0](https://www.opengreenenergy.com/solar-powered-wifi-weather-station-v3-0/).
That project ships with C++ firmware. Pascal converted the build to ESPHome,
then lived with a flat YAML version for his own station.

That old flat YAML did a lot: board setup, WiFi, battery, sun data, BME280,
external temperature, light, air sensors, wind, rain, and more. Useful when it
works. Awkward when it does not. Basic gives us a clean baseline that can boot,
report useful values, and prove the core station hardware before we add moving
outdoor sensors.

## What Problems It Solves

This project answers the first weather-station questions:

- Is the ESP32 station board alive and reachable?
- Is the basic I2C bus healthy?
- Are temperature, humidity, pressure, light, and external temperature reading?
- Is the battery voltage visible?
- Are the sun helpers available for later automations and dashboards?

Once those are stable, wind and rain become much easier to debug.

## What Possibilities It Creates

Basic can feed local dashboards, garden notes, irrigation decisions, ventilation
ideas, and weather history. It is not a replacement for a calibrated weather
station yet. It is the foundation for getting there without turning the first
test into a full outdoor science fair.

## Project Fit

| Factor | Rating | Notes |
| --- | --- | --- |
| Difficulty | Intermediate | The YAML is simple, but the hardware is outdoor and solar-adjacent. |
| Estimated cost | Medium | Cheaper if the old station hardware is already built. |
| Build time | 1-2 hours | More if the enclosure, wiring, or battery setup needs repair. |
| Tools needed | Soldering and multimeter | A USB cable and basic ESPHome setup are also assumed. |
| Off-the-shelf viability | Either | Buy if you want polished weather data quickly; build if local control and repairability matter. |
| Maintenance burden | Medium | Outdoor sensors, battery, enclosure seals, and calibration all need attention. |

## Hardware And Bill Of Materials

| Item | Recommended Part | Image | Viable Alternatives | Notes |
| --- | --- | --- | --- | --- |
| Controller | HAZA Weather Station Board v1 | To do: `assets/haza-weather-station-board-v1.png` | ESP32 DevKit style board with matching pins | This recipe uses the dedicated HAZA board package for Pascal's station hardware. The Open Green Energy board package is separate and will be reviewed later. |
| Temperature, humidity, and pressure | BME280 module | To do: `assets/bme280-sensor.png` | BMP280 | BMP280 does not expose humidity and needs a different project decision. |
| External temperature | DS18B20 waterproof probe | To do: `assets/ds18b20-probe.png` | Other waterproof temperature sensors | The 1-Wire address may need to be updated. |
| UV and ambient light | LTR390 module | To do: `assets/ltr390-sensor.png` | BH1750 for illuminance-only builds | This weather station board uses LTR390 at `0x53`; BH1750 is not fitted here. |
| Battery monitoring | Voltage divider into ESP32 ADC | To do: `assets/battery-voltage-divider.png` | Dedicated fuel gauge module | The percentage estimate must be calibrated to the actual divider and battery. |
| Power | Solar-charged 18650 setup | To do | USB power for bench testing | Solar/battery wiring must be checked carefully before outdoor use. |

## Wiring

Pascal will provide the final wiring diagram after the station is back on the
bench.

```text
[Image placeholder: assets/wiring-breadboard.png]
```

Current expected wiring from the historical build:

| Component | Pin | Connects To | Notes |
| --- | --- | --- | --- |
| BME280 | SDA | GPIO21 | Shared I2C bus. |
| BME280 | SCL | GPIO22 | Shared I2C bus. |
| BME280 | VCC | 3V3 | Check the module voltage. |
| BME280 | GND | GND | Common ground. |
| LTR390 | SDA | GPIO21 | Shared I2C bus. |
| LTR390 | SCL | GPIO22 | Shared I2C bus. |
| LTR390 | VCC | 3V3 | Check the module voltage. |
| LTR390 | GND | GND | Common ground. |
| DS18B20 | DATA | GPIO4 | Uses the 1-Wire package. |
| Battery divider | OUT | GPIO33 | Must be calibrated to the actual divider. |

Expected I2C addresses:

- LTR390: `0x53`
- BME280: `0x76`

## Framework Packages Used

- Board: `boards/esp32/haza_weather_station_v1.yaml`
- Core: `common/core/settings.yaml`
- Time: `common/time/home_assistant.yaml`
- Sun: `common/core/sun.yaml`
- Network helpers: `common/network/wifi.yaml`
- Public recipe network: `common/network/wifi_dynamicip.yaml`
- Web server: `common/network/webserver.yaml`
- Sensor: `sensors/i2c/bme280.yaml`
- Sensor: `sensors/one_wire/ds18b20.yaml`
- Sensor: `sensors/i2c/ltr390.yaml`

## Validation So Far

Alfred validated the modular YAML locally with ESPHome 2026.7.3:

- Config: pass
- Compile: pass
- Firmware size: 1,078,715 bytes
- RAM: 27.1%
- Flash: 58.8%

ESPHome warns that GPIO2 is a strapping pin. That matches the historical board
definition and is acceptable for this stage, but the attached status LED
hardware should not interfere with boot.

Pascal then validated and revalidated the Desktop upload copy on real hardware
with ESPHome 2026.8 beta on 2026-08-22:

- Compile: pass
- Serial push: pass
- Log check: pass
- ESPHome web server check: pass

The supplied web screenshot confirmed BME280, DS18B20, WiFi diagnostics, uptime,
and battery ADC entities. The board later turned out to have an LTR390 at
`0x53`, not a BH1750 at `0x23`, so the light/UV package has been corrected.

## Setup

Before compiling, set these substitutions for the real deployment:

- `location_latitude`
- `location_longitude`
- `ds18b20_address`
- `battery_empty_voltage`
- `battery_full_voltage`

The public recipe uses safe placeholder coordinates. Do not treat them as
Pascal's location or as your own location.

## Home Assistant Entities

Expected user-facing entities for this first stage:

- BME280 Temperature (C)
- BME280 Humidity
- BME280 Atmospheric Pressure
- BME280 Dew Point
- DS18B20 Temperature
- LTR390 UV Index
- LTR390 UV Sensor
- LTR390 Light
- LTR390 Ambient Light
- LTR390 Illuminance Human Readable
- LTR390 UV Exposure Level
- Battery Voltage
- Battery Percentage
- Sun Next Sunrise
- Sun Next Sunset
- Sun Elevation
- Sun Azimuth
- Uptime
- IP Address
- Connected SSID
- Wifi Signal Strength

The exact entity IDs depend on the device substitutions used for the local
deployment.

## Calibration And Tuning

Battery percentage is only an estimate until the voltage divider and battery
range are checked on the real station.

The DS18B20 address may also need to be discovered from logs if the old probe
was replaced.

## Screenshots And Visual Checks

To add during documentation cleanup:

```text
[Image placeholder: ESPHome web server view for Weather Sense Basic]
[Image placeholder: Home Assistant device page for Weather Sense Basic]
[Image placeholder: close-up of the board, BME280, DS18B20, LTR390, and battery wiring]
[Image placeholder: Fritzing wiring diagram]
```

## Validation Evidence

See [validation.md](validation.md).

## Troubleshooting

See [troubleshooting.md](troubleshooting.md).

## Related Variants

- Weather Sense Wind: adds anemometer and wind vane.
- Weather Sense Wind and Rain: adds the tipping-bucket rain gauge.
- Weather Sense Air: current production target with CCS811 eCO2 and TVOC.
- Weather Sense V4.0: future branch based on the Open Green Energy / PCBWay
  V4.0 design.
- Pascal Weather Sense: future branch based on Pascal's own board design.

## Credits And Source Hardware

This project is built around the Open Green Energy Solar Powered WiFi Weather
Station V3.0 hardware design:

- <https://www.opengreenenergy.com/solar-powered-wifi-weather-station-v3-0/>

The original project uses C++ firmware. This HAZA version is Pascal's ESPHome
conversion, split into reusable board, sensor, common, and project packages so
the station can be rebuilt and validated one stage at a time.

## Change Notes

- 2026-08-22: Created Weather Sense Basic from the historical flat weather
  station YAML and existing framework packages.
