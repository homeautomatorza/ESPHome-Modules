<p align="center">
  <img src="assets/room-sense-plus-hero.svg" width="100%" alt="Room Sense Plus: ESP32-C3 room sensor with temperature, humidity, light, and indoor air-quality sensing">
</p>

> [!WARNING]
> **Disclaimer:** These files are shared as-is, with the usual "it works in my
> environment" honesty baked in. They come from real builds, test devices, and
> ongoing experiments, but they are not guaranteed to work safely or correctly
> in your setup. Check the code, wiring, pins, power, secrets, calibration, and
> local rules and regulations before using anything.

Room Sense Basic tells us how the room feels through temperature, humidity,
dew point and light. Plus adds an indoor-air signal with the ENS160: eCO2,
TVOC and the sensor's air quality index.

This is useful when a room feels stale, people complain about headaches, plants
are sensitive to airflow, or you want Home Assistant to have more than just
temperature and humidity before making ventilation decisions.

I used this model in my study, kitchen, workshop and all my bedrooms, where
these sensors were most useful in my home. I have since upgraded most of them
to Room Sense Air.

<details>

<summary><b>Current Status</b></summary><br>

- YAML recipe: [`esphome_room_sense_plus_project.yaml`](esphome_room_sense_plus_project.yaml)
- Alternate YAML recipe: [C6/SGP30 alternate](https://github.com/homeautomatorza/ESPHome-Modules/blob/79c989b279b55249b76417bd184105343a8d5798/recipes/projects/room_sense/plus/esphome_room_sense_plus_project_alternate.yaml); outside this C3/ENS160 release approval
- Config validation: Frozen C3 recipe passed on ESPHome `2026.10.0`, `2026-11-07`; historical recipe pass on `2026.7.3`
- Compile evidence: Historical recipe pass on ESPHome `2026.7.3`; production startup log confirms firmware built with `2026.10.1`
- Physical validation: C3/ENS160 production update passed OTA, startup-log
  review, ESPHome web-server and Home Assistant visual checks on `2026-11-07`
  with ESPHome `2026.10.1`
- Historical alternate evidence: ESP32-C6, BME280, BH1750, and SGP30 passed config,
  compile, OTA, web access, and live-value checks on a private validation device
- Documentation approval: C3/ENS160 approved by Pascal, `2026-11-07`
- Maintenance: C3/ENS160 complete and frozen. Future ESPHome validation checks
  and their results may be recorded; other changes require Pascal to reopen
  this release. The C6/SGP30 alternate is outside this approval.

Full validation notes live in [validation.md](documents/validation.md).

</details>

## Project Profile

| Factor | Rating | Notes |
| --- | --- | --- |
| Difficulty | Intermediate | Same I2C wiring as Basic, with one extra sensor and more values to interpret. |
| Estimated cost | Low to medium | Depends on the ENS160 module price and what parts you already have. |
| Build time | 1-2 hours | Allow extra time to confirm I2C addresses and sensor placement. |
| Tools needed | Basic plus soldering | USB cable, Dupont wires, breadboard or soldering tools, and a computer. |
| Off-the-shelf viability | Either | Buy if you want a finished air-quality device. Build if you want ESPHome packages and custom room logic. |
| Maintenance burden | Medium | Placement matters, and air-quality interpretation needs common sense. |

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

## Hardware And Bill Of Materials

| Item | Recommended Part | Image | Viable Alternatives | Notes |
| --- | --- | --- | --- | --- |
| Controller | ESP32-C3 Super Mini | ![ESP32-C3 Super Mini](assets/esp32-c3-super-mini.png) | Other ESP32-C3 boards | Pin mapping and board package may change. |
| Temperature and humidity | AHT20 module | ![AHT20 temperature and humidity sensor](assets/aht20.png) | SHT40, BME280 | Alternatives need matching YAML packages and may expose different entities. |
| Illuminance | BH1750 module | ![BH1750 illuminance sensor](assets/bh1750.png) | Other ESPHome-supported lux sensors | Wiring and package will change. |
| VOC and eCO2 | ENS160 module | ![Adafruit ENS160 VOC and eCO2 sensor module](assets/ens160.png) | SGP30, CCS811 | Alternatives need different packages and different interpretation. |
| Wiring | Dupont leads or soldered wire | — | JST/Grove/Qwiic if your modules support it | Keep power, ground, SDA, and SCL clear and consistent. |

> [!WARNING]
> Alternatives are not automatically drop-in replacements. Check the matching
> framework package, GPIO mapping, I2C address, voltage, wiring, enclosure, and
> interpretation before relying on a changed board or sensor.

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

## Wiring

Disconnect power before changing wiring. Check the exact hardware's supply and
signal levels against the controller GPIO limits before connecting it. GPIO9
is a strapping pin on the ESP32-C3; check boot behaviour after wiring changes.


![Room Sense Plus Fritzing wiring diagram with an ESP32-C3 Super Mini, AHT20, BH1750 and ENS160](assets/fritzing.png)

Use the wiring table when checking the diagram. On the pictured Adafruit
ENS160 breakout, use VIN for power; 3Vo is a regulator output. SDI is SDA and
SCK is SCL. See the [manufacturer's pin guide](https://learn.adafruit.com/adafruit-ens160-mox-gas-sensor/pinouts).

| Component | Pin | Connects To | Notes |
| --- | --- | --- | --- |
| AHT20 | VCC | 3V3 | Use 3.3 V unless your module explicitly supports another voltage. |
| AHT20 | GND | GND | Common ground with the ESP32-C3. |
| AHT20 | SDA | GPIO9 | Shared I2C bus. |
| AHT20 | SCL | GPIO10 | Shared I2C bus. |
| BH1750 | VCC | 3V3 | Use 3.3 V unless your module explicitly supports another voltage. |
| BH1750 | GND | GND | Common ground with the ESP32-C3. |
| BH1750 | SDA | GPIO9 | Shared I2C bus. |
| BH1750 | SCL | GPIO10 | Shared I2C bus. |
| ENS160 | VIN | 3V3 | Use 3.3 V unless your module explicitly supports another voltage. |
| ENS160 | GND | GND | Common ground with the ESP32-C3. |
| ENS160 | SDI (SDA) | GPIO9 | Shared I2C bus. |
| ENS160 | SCK (SCL) | GPIO10 | Shared I2C bus. |

For the SGP30 alternate, use the same shared I2C idea, but follow the board
package used by that YAML. The verified alternate uses the ESP32-C6 Super Mini,
BME280, BH1750, and SGP30 on C6 I2C SDA `GPIO14` and SCL `GPIO18`.

Expected I2C addresses:

- BH1750: `0x23`
- AHT20: `0x38`
- ENS160: `0x53`
- SGP30 alternate: `0x58`

## Setup

1. Open the [C3/ENS160 recipe](esphome_room_sense_plus_project.yaml). You can
   copy it into your ESPHome configuration folder: its shared packages are
   pinned to the tested public revision below. The
   [C6/SGP30 alternate](https://github.com/homeautomatorza/ESPHome-Modules/blob/79c989b279b55249b76417bd184105343a8d5798/recipes/projects/room_sense/plus/esphome_room_sense_plus_project_alternate.yaml) retains
   repository-relative includes and is outside this frozen release.
2. Review device substitutions, the selected board and sensor addresses.
3. Provide the required secret bindings in your device's own `secrets.yaml`.
4. Validate the configuration, then compile.
5. For a new or repurposed board, follow the erase-first guidance in
   [First Firmware Upload](https://github.com/homeautomatorza/ESPHome-Modules/wiki/first-firmware-upload).
6. Upload, then confirm the expected I2C sensors in the logs and web server.
7. Add or review the device in Home Assistant and compare its readings with the room state.

If you are replacing an existing ESPHome device, match any existing OTA password
for the first migration upload. To move to encrypted OTA using the API key,
first install firmware built with ESPHome `2026.9.0` or newer while retaining
that password, then enable OTA `encryption:` and remove the password for the
next upload. See [OTA troubleshooting](documents/troubleshooting.md#ota-upload-asks-for-a-password)
for the migration and recovery options.

<details>

<summary><b>Framework Packages Used</b></summary><br>

The C3/ENS160 release pins these packages to public commit
[`79c989b`](https://github.com/homeautomatorza/ESPHome-Modules/tree/79c989b279b55249b76417bd184105343a8d5798).
This is the package revision cached by the production device validated on
`2026-11-07`. Later framework changes do not alter this release.

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

</details>

## Visual Checks

### ESPHome Web Server

> [!TIP]
> From ESPHome 2026.6 or newer, you can access the device web server from ESPHome
> Device Builder. See
> [Finding Your Way Around ESPHome](https://github.com/homeautomatorza/ESPHome-Modules/wiki/esphome-ui-primer).

![ESPHome web server view](assets/device-web-server.png)

Use this screen to confirm the device is alive locally and the ESPHome-side
values look sensible before spending time debugging Home Assistant.

## Home Assistant Entities

<details>

<summary><b>Expected user-facing entities</b></summary><br>

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

</details>

### Home Assistant Device Page

![Home Assistant device view](assets/home-assistant-device.png)

Use this screen to confirm the device integrated correctly and the expected
entities are visible in Home Assistant.

Both screenshots were supplied by Pascal on `2026-11-07`. Private device and
network details are redacted; sensor readings are unchanged.

## Calibration And Tuning

No formal calibration is included yet.

Placement still matters:

- Keep the AHT20 exposed to room air.
- Keep the BH1750 exposed to representative room light.
- Keep the ENS160 away from heat, solvents, cleaning products, and direct
  airflow unless that is the condition you are deliberately testing.
- Let the device run for a while before judging the ENS160 readings.

## Known Limitations

- The C6/SGP30 alternate has historical validation evidence but is outside
  this C3/ENS160 release approval.
- ENS160 readings are practical indoor-air indicators, not certified
  measurements.
- SGP30 readings are also practical indoor-air indicators, not certified
  measurements.

## Validation Evidence

See [validation.md](documents/validation.md).

## Troubleshooting

See [troubleshooting.md](documents/troubleshooting.md).

## Changelog

See [changelog.md](documents/changelog.md).

## Related Projects And Next Variants

Check each guide's wiring, packages and validation notes before changing your
build; these variants use different sensor and board combinations.

- [Room Sense Basic](https://github.com/homeautomatorza/ESPHome-Modules/blob/main/recipes/projects/room_sense/basic/README.md): temperature, humidity and light sensing.
- [Room Sense Air](https://github.com/homeautomatorza/ESPHome-Modules/blob/main/recipes/projects/room_sense/air/README.md): comfort, light and indoor-air sensing with SPS30 particulate measurements.
- [Room Sense Motion](https://github.com/homeautomatorza/ESPHome-Modules/blob/main/recipes/projects/room_sense/motion/README.md): comfort and light sensing with HC-SR501 PIR movement detection.
- [Room Sense Presence](https://github.com/homeautomatorza/ESPHome-Modules/blob/main/recipes/projects/room_sense/presence/README.md): comfort and light sensing with PIR movement and LD2410C mmWave presence detection.
- [Room Sense Max](https://github.com/homeautomatorza/ESPHome-Modules/blob/main/recipes/projects/room_sense/max/README.md): the combined comfort, light, indoor-air, particulate, movement and presence build.
