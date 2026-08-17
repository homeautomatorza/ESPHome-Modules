# HAZA Room Sense Plus

> [!WARNING]
> **Disclaimer:** These files are shared as-is, with the usual "it works in my
> environment" honesty baked in. They come from real builds, test devices, and
> ongoing experiments, but they are not guaranteed to work safely or correctly
> in your setup. Check the code, wiring, pins, power, secrets, calibration, and
> local rules and regulations before using anything.

`HAZA Room Sense Plus` is the next step after Room Sense Basic.

Basic tells us how the room feels through temperature, humidity, dew point, and
light. Plus adds a first indoor-air signal with the ENS160: eCO2, TVOC, and the
sensor's air quality index.

This is useful when a room feels stale, people complain about headaches, plants
are sensitive to airflow, or you want Home Assistant to have more than just
temperature and humidity before making ventilation decisions.

## YouTube Video

To do, if this project is filmed.

## Current Status

- YAML recipe: `esphome_room_sense_plus_project.yaml`
- Alternate YAML recipe: `esphome_room_sense_plus_project_alternate.yaml`
- Config validation: Passed on ESPHome `2026.7.3`
- Compile validation: Passed on ESPHome `2026.7.3`
- Physical validation: ENS160 recipe passed OTA and web visual confirmation on
  a private validation device
- Verified alternate: ESP32-C6, BME280, BH1750, and SGP30 passed config,
  compile, OTA, web access, and live-value checks on a private validation device
- Documentation approval: Draft, pending Pascal review

Full validation notes live in [validation.md](validation.md).

## Why Build This?

Temperature and humidity explain part of a room, but not all of it.

Sometimes a room is the right temperature and still feels wrong. It may need
fresh air, or it may have cleaning-product fumes, printer smells, cooking
residue, or general indoor-air buildup.

Room Sense Plus adds a VOC and eCO2 view so we can start seeing those patterns.
The main recipe uses ENS160. The alternate recipe uses SGP30 where that module
is a better fit or is what you already have on hand.

Neither version makes the device a certified air-quality monitor. It gives Home
Assistant a practical signal that can help with ventilation experiments and
future automations.

## What Problems It Solves

- Keeps the Basic temperature, humidity, dew point, and illuminance readings.
- Adds ENS160 eCO2 as a ventilation-style indicator.
- Adds ENS160 TVOC as a volatile-organic-compound indicator.
- Adds the ENS160 air quality index.
- Creates a path toward smarter fan, window, extractor, and HVAC decisions.

## What Possibilities It Creates

Once the readings are in Home Assistant, they can help answer questions like:

- Does this room get stale when the door is closed?
- Does ventilation improve the readings?
- Do certain activities create repeatable VOC spikes?
- Should a fan, extractor, or air purifier run for a while?
- Is a later particulate-sensing Room Sense Air build worth adding here?

Keep the first automations cautious. Treat ENS160 values as useful indicators,
not lab-grade proof.

## What This Project Does

The device exposes:

- AHT20 temperature
- AHT20 humidity
- AHT20 calculated dew point
- BH1750 illuminance
- BH1750 illuminance human-readable label
- ENS160 eCO2
- ENS160 TVOC
- ENS160 air quality index
- ENS160 human-readable classification labels from the shared package
- standard ESPHome diagnostic entities from the shared framework packages

## Who This Is For

Build this if Room Sense Basic is working and you want a first indoor-air
quality signal.

It is especially useful if you are:

- testing room ventilation ideas
- comparing rooms that feel different
- planning a fan, extractor, or air purifier automation
- building toward Room Sense Air or Room Sense Presence later

Skip it for now if you need certified air-quality measurements, CO2 compliance
logging, or particulate measurements. That is not what this project claims.

## Project Fit

| Factor | Rating | Notes |
| --- | --- | --- |
| Difficulty | Intermediate | Same I2C wiring as Basic, with one extra sensor and more values to interpret. |
| Estimated cost | Low to medium | Depends on the ENS160 module price and what parts you already have. |
| Build time | 1-2 hours | Allow extra time to confirm I2C addresses and sensor placement. |
| Tools needed | Basic plus soldering | USB cable, Dupont wires, breadboard or soldering tools, and a computer. |
| Off-the-shelf viability | Either | Buy if you want a finished air-quality device. Build if you want ESPHome packages and custom room logic. |
| Maintenance burden | Medium | Placement matters, and air-quality interpretation needs common sense. |

## Hardware And Bill Of Materials

### Visual Reference

Add clean component photos here as they become available.

```text
[Image placeholder: ESP32-C3 Super Mini on a clean background]
[Image placeholder: AHT20 temperature and humidity sensor]
[Image placeholder: BH1750 illuminance sensor]
[Image placeholder: ENS160 VOC/eCO2 sensor]
[Image placeholder: assembled Room Sense Plus validation device]
```

| Item | Recommended Part | Image | Viable Alternatives | Notes |
| --- | --- | --- | --- | --- |
| Controller | ESP32-C3 Super Mini | To do: `assets/esp32-c3-super-mini.png` | Other ESP32-C3 boards | Pin mapping and board package may change. |
| Temperature and humidity | AHT20 module | To do: `assets/aht20-sensor.png` | SHT40, BME280 | Alternatives need matching YAML packages and may expose different entities. |
| Illuminance | BH1750 module | To do: `assets/bh1750-sensor.png` | Other ESPHome-supported lux sensors | Wiring and package will change. |
| VOC and eCO2 | ENS160 module | To do: `assets/ens160-sensor.png` | SGP30, CCS811 | Alternatives need different packages and different interpretation. |
| Wiring | Dupont leads or soldered wire | Optional build photo | JST/Grove/Qwiic if your modules support it | Keep power, ground, SDA, and SCL clear and consistent. |
| Mounting | Project box or printed enclosure | To do | Breadboard for testing | Keep sensor openings exposed to room air and representative light. |

## Wiring

Pascal will provide the Fritzing diagram for the final build.

```text
[Image placeholder: assets/wiring-breadboard.png]
```

Use the wiring table when checking the diagram.

| Component | Pin | Connects To | Notes |
| --- | --- | --- | --- |
| AHT20 | VCC | 3V3 | Use 3.3V unless your module explicitly supports another voltage. |
| AHT20 | GND | GND | Common ground with the ESP32-C3. |
| AHT20 | SDA | GPIO9 | Shared I2C bus. |
| AHT20 | SCL | GPIO10 | Shared I2C bus. |
| BH1750 | VCC | 3V3 | Use 3.3V unless your module explicitly supports another voltage. |
| BH1750 | GND | GND | Common ground with the ESP32-C3. |
| BH1750 | SDA | GPIO9 | Shared I2C bus. |
| BH1750 | SCL | GPIO10 | Shared I2C bus. |
| ENS160 | VCC | 3V3 | Use 3.3V unless your module explicitly supports another voltage. |
| ENS160 | GND | GND | Common ground with the ESP32-C3. |
| ENS160 | SDA | GPIO9 | Shared I2C bus. |
| ENS160 | SCL | GPIO10 | Shared I2C bus. |

For the SGP30 alternate, use the same shared I2C idea, but follow the board
package used by that YAML. The verified alternate uses the ESP32-C6 Super Mini,
BME280, BH1750, and SGP30.

Expected I2C addresses:

- BH1750: `0x23`
- AHT20: `0x38`
- ENS160: `0x53`
- SGP30 alternate: `0x58`

## Framework Packages Used

- Board: `boards/esp32/c3_super_mini.yaml`
- Core: `common/core/settings.yaml`
- Time: `common/time/home_assistant.yaml`
- Network helpers: `common/network/wifi.yaml`
- Public recipe network: `common/network/wifi_dynamicip.yaml`
- Web server: `common/network/webserver.yaml`
- Sensor: `sensors/i2c/bh1750.yaml`
- Sensor: `sensors/i2c/aht2x_3x.yaml`
- Sensor: `sensors/i2c/ens160.yaml`

The SGP30 alternate uses:

- Board: `boards/esp32/c6_super_mini.yaml`
- Sensor: `sensors/i2c/bme280.yaml`
- Sensor: `sensors/i2c/sgp30.yaml`

## Setup

1. Compile the recipe YAML from this folder.
2. Confirm all three I2C sensors appear at the expected addresses.
3. Upload the firmware.
4. Check the ESPHome web server.
5. Add or review the device in Home Assistant.
6. Compare the readings with the room state and note what looks sensible.

If you are replacing an existing ESPHome device, match any existing OTA password
for the first migration upload, or use web OTA/serial flashing.

## Home Assistant Entities

Expected user-facing entities:

- AHT20 Temperature (C)
- AHT20 Humidity
- AHT20 Dew Point
- BH1750 Illuminance
- BH1750 Illuminance Human Readable
- ENS160 eCO2
- ENS160 Total Volatile Organic Compounds
- ENS160 Air Quality Index
- ENS160 eCO2 Classification
- ENS160 TVOC Level
- ENS160 Air Quality Rating
- Uptime
- IP Address
- Connected SSID
- Wifi Signal Strength

The exact entity IDs depend on the device substitutions used for the local
deployment.

The SGP30 alternate exposes these air-quality entities instead of the ENS160
entities:

- SGP30 eCO2
- SGP30 eCO2 Classification
- SGP30 TVOC
- SGP30 TVOC Level

## Screenshots And Visual Checks

To add during physical validation:

```text
[Image placeholder: ESPHome web server view for Room Sense Plus]
[Image placeholder: Home Assistant device page for Room Sense Plus]
[Image placeholder: close-up of assembled board and sensors]
[Image placeholder: device installed in the room]
[Image placeholder: Fritzing wiring diagram]
```

## Calibration And Tuning

No formal calibration is included yet.

Placement still matters:

- Keep the AHT20 exposed to room air.
- Keep the BH1750 exposed to representative room light.
- Keep the ENS160 away from heat, solvents, cleaning products, and direct
  airflow unless that is the condition you are deliberately testing.
- Let the device run for a while before judging the ENS160 readings.

## Validation Evidence

See [validation.md](validation.md).

## Troubleshooting

See [troubleshooting.md](troubleshooting.md).

## Known Limitations

- The ENS160 Plus recipe still needs its final documentation screenshots.
- The SGP30 alternate was validated on a private C6/BME280 validation device.
- ENS160 readings are practical indoor-air indicators, not certified
  measurements.
- SGP30 readings are also practical indoor-air indicators, not certified
  measurements.
- PM2.5, movement, and presence are not part of Plus.
- Component images and final wiring diagrams are still being added.

## Related Projects And Next Variants

- HAZA Room Sense Basic: temperature, humidity, dew point, and illuminance.
- HAZA Room Sense Plus: Basic plus eCO2 and TVOC.
- HAZA Room Sense Air: Plus plus PM2.5 or particulate sensing.
- HAZA Room Sense Presence: movement and presence focused variant.
- HAZA Room Sense Max: reserved for the full combined room sensor.

## Change Notes

- 2026-08-17: Added `esphome_room_sense_plus_project_alternate.yaml` as a
  verified SGP30 alternate using ESP32-C6, BME280, BH1750, and SGP30.
- 2026.0.0: Created the Room Sense Plus project from Room Sense Basic and
  added the ENS160 VOC/eCO2 package.
