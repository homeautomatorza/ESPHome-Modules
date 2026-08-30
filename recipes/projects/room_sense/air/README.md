<p align="center">
  <img src="../../../../.github/images/readme/room-sense-air-hero.svg" width="100%" alt="HAZA Room Sense Air: ESP32-C6 room sensor with comfort, light, indoor air-quality, and particulate sensing">
</p>

> [!WARNING]
> **Disclaimer:** This project is being built one sensor at a time on real
> hardware. Stage 3 has passed on the validation device, but it still carries
> the normal "it works in my environment" warning until more builds repeat it.

`HAZA Room Sense Air` is the air-focused Room Sense variant.

The final direction is Room Sense Plus-style room sensing, with particulate
matter added through an SPS30. We are bringing it up slowly: first the C6 board,
BH1750, and BME280; then SGP30; then SPS30; then movement and presence.

<details>

<summary><b>Current Status</b></summary><br>

- YAML recipe: `esphome_room_sense_air_project.yaml`
- Board: ESP32-C6 Super Mini
- Current stage: Stage 3 SPS30 hardware validation passed
- Config validation: Passed on ESPHome `2026.7.3`
- Compile validation: Passed on ESPHome `2026.7.3`
- Physical validation: Stage 3 passed on a private validation device
- Live value check: ESPHome web server showed BH1750, BME280, SGP30, and SPS30
  values
- Shared defaults: OTA and authenticated web access passed after local overrides
  were removed
- SGP30 stage: Config and compile passed; Pascal reported the stage working as
  expected on the private validation device
- SPS30 stage: Compile, OTA, log, and web checks passed on `2026-08-17`
- Documentation approval: Draft, pending Pascal review

Full validation notes live in [validation.md](documents/validation.md).

</details>

## Project Profile

| Factor | Rating | Notes |
| --- | --- | --- |
| Difficulty | Intermediate to advanced | Several I2C sensors share one bus, and the SPS30 needs careful power, cable, and airflow planning. |
| Estimated cost | High | The particulate sensor accounts for much of the cost. |
| Build time | Half a day | Allow extra time for staged testing and sensor placement. |
| Tools needed | Soldering and basic test gear | A USB data cable, jumper wires, a breadboard, and a multimeter are useful during bring-up. |
| Off-the-shelf viability | Either | Buy for a finished enclosure; build for local control, repairability, and a custom sensor mix. |
| Maintenance burden | Medium | Keep the SPS30 airflow path clear and review air-quality readings over time. |

> [!TIP]
> See [Recommended Starter Hardware](https://github.com/homeautomatorza/ESPHome-Modules/wiki/recommended-starter-hardware)
> and [Recommended Starter Tools](https://github.com/homeautomatorza/ESPHome-Modules/wiki/recommended-starter-tools).

## Why Build This?

Room Sense Basic tells us how a room feels. Room Sense Plus adds indoor-air
signals with eCO2 and TVOC. Room Sense Air is where we start asking a sharper
question: what is actually floating around in the room?

The SPS30 stage will make this useful for dust, smoke, workshop air, cooking
effects, and ventilation experiments. The BME280 stage is first because it gives
us a clean C6 baseline with temperature, humidity, pressure, and dew point before
we add the larger sensor stack.

## What Problems It Solves

- Puts comfort, light, gas estimates, and particulate readings on one local device.
- Makes dust, smoke, cooking, and ventilation changes visible in Home Assistant.
- Provides a staged path for diagnosing one sensor before adding the next.

## What Possibilities It Creates

- Ventilation alerts based on more than temperature alone.
- Comparisons between room activity, particulate levels, and changing air quality.
- A foundation for later movement and presence-aware air-quality automations.

## Hardware And Bill Of Materials

| Item | Recommended Part | Image | Viable Alternatives | Notes |
| --- | --- | --- | --- | --- |
| Controller | ESP32-C6 Super Mini | To do: `assets/esp32-c6-super-mini.png` | Other ESP32-C6 boards | Pin mapping and board package may change. |
| Temperature, humidity, and pressure | BME280 module | To do: `assets/bme280-sensor.png` | BMP280 | BMP280 does not expose humidity and needs a different package. |
| Illuminance | BH1750 module | To do: `assets/bh1750-sensor.png` | Other ESPHome-supported lux sensors | Wiring and package will change. |
| eCO2 and TVOC | SGP30 module | To do | ENS160, CCS811 | Added in Stage 2. Alternatives need different packages and interpretation. |
| Particulate matter | SPS30 module | To do | PMSx003 family | Added in Stage 3. Wiring, airflow, and placement matter. |


> [!WARNING]
> The alternatives in this table are not drop-in replacements. A different
> board or sensor may change the framework package, GPIO mapping, I2C address,
> wiring, voltage, enclosure, or calibration. Validate, compile, and test each
> changed stage before relying on it.

## Who This Is For

Build this if you want a local, repairable room monitor that includes particulate
matter and you are comfortable testing a larger sensor stack one stage at a
time. Start with Room Sense Basic or Plus if you are new to ESPHome, need a
smaller enclosure, or do not yet need particulate sensing.

## Wiring

Pascal will provide the Fritzing diagram after the staged hardware checks.

```text
[Image placeholder: assets/wiring-breadboard.png]
```

Current stage:

| Component | Pin | Connects To | Notes |
| --- | --- | --- | --- |
| BH1750 | VCC | 3V3 | Use 3.3V unless your module explicitly supports another voltage. |
| BH1750 | GND | GND | Common ground with the ESP32-C6. |
| BH1750 | SDA | GPIO14 | I2C SDA from `boards/esp32/c6_super_mini.yaml`. |
| BH1750 | SCL | GPIO18 | I2C SCL from `boards/esp32/c6_super_mini.yaml`. |
| BME280 | VCC | 3V3 | Use 3.3V unless your module explicitly supports another voltage. |
| BME280 | GND | GND | Common ground with the ESP32-C6. |
| BME280 | SDA | GPIO14 | Shared I2C bus. |
| BME280 | SCL | GPIO18 | Shared I2C bus. |
| SGP30 | VCC | 3V3 | Uses BME280 temperature and humidity compensation. |
| SGP30 | GND | GND | Common ground with the ESP32-C6. |
| SGP30 | SDA | GPIO14 | Shared I2C bus. |
| SGP30 | SCL | GPIO18 | Shared I2C bus. |
| SPS30 | VCC | Module-safe supply | Check your SPS30 board or cable. |
| SPS30 | GND | GND | Common ground with the ESP32-C6. |
| SPS30 | SDA | GPIO14 | Shared I2C bus. |
| SPS30 | SCL | GPIO18 | Shared I2C bus. |

Expected I2C addresses:

- BH1750: `0x23`
- BME280: `0x76`
- SGP30: `0x58`
- SPS30: `0x69`

## Setup

1. Copy or import the [recipe YAML](esphome_room_sense_air_project.yaml).
2. Review the device substitutions and enable only the stage you have wired.
3. Confirm the required secret names exist in your own `secrets.yaml`.
4. Validate the configuration, then compile the firmware.
5. For a new or repurposed board, follow [First Firmware Upload](https://github.com/homeautomatorza/ESPHome-Modules/wiki/first-firmware-upload).
6. Add one sensor stage at a time and check the logs and web server after each change.
7. Add or review the device in Home Assistant.

<details>

<summary><b>Framework Packages Used</b></summary><br>

- Board: `boards/esp32/c6_super_mini.yaml`
- Core: `common/core/settings.yaml`
- Time: `common/time/home_assistant.yaml`
- Network helpers: `common/network/wifi.yaml`
- Public recipe network: `common/network/wifi_dynamicip.yaml`
- Web server: `common/network/webserver.yaml`
- Sensor: `sensors/i2c/bh1750.yaml`
- Sensor: `sensors/i2c/bme280.yaml`
- Sensor: `sensors/i2c/sgp30.yaml`
- Sensor: `sensors/i2c/sps30.yaml`

</details>

## Visual Checks

To add during documentation cleanup:

```text
[Image placeholder: ESPHome web server view for Room Sense Air stage 3 - captured, pending asset file]
[Image placeholder: Home Assistant device page for Room Sense Air stage 3]
[Image placeholder: close-up of the C6, BH1750, BME280, SGP30, and SPS30 wiring]
[Image placeholder: Fritzing wiring diagram]
```

## Home Assistant Entities

<details>

<summary><b>Expected user-facing entities</b></summary><br>

Expected user-facing entities for the current stage:

- BME280 Temperature (C)
- BME280 Humidity
- BME280 Atmospheric Pressure
- BME280 Dew Point
- BH1750 Illuminance
- BH1750 Illuminance Human Readable
- SGP30 eCO2
- SGP30 eCO2 Classification
- SGP30 TVOC
- SGP30 TVOC Level
- SPS30 PM <1um Weight concentration
- SPS30 PM <2.5um Weight concentration
- SPS30 PM <4um Weight concentration
- SPS30 PM <10um Weight concentration
- SPS30 Fan Clean
- Uptime
- IP Address
- Connected SSID
- Wifi Signal Strength

The SPS30 number concentration, typical particle size, and AQI entities are
available in the module but disabled by default. We can enable them later if the
project needs that extra detail.

The exact entity IDs depend on the device substitutions used for the local
deployment.

</details>

## Calibration And Tuning

Place the environmental sensors away from board heat and direct drafts. Keep
the SPS30 inlet and outlet unobstructed, and give the SGP30 enough operating
time before treating its readings as a useful baseline. The planned PIR and
presence stages will need their own placement and sensitivity checks when they
are added.

## Validation Evidence

See [validation.md](documents/validation.md).

## Troubleshooting

See [troubleshooting.md](documents/troubleshooting.md).

## Changelog

See [changelog.md](documents/changelog.md).

## Related Projects And Next Variants

- Room Sense Basic for temperature, humidity, and light only.
- Room Sense Plus for gas estimates without particulate sensing.
- Room Sense Max for the full air, movement, and presence stack.
