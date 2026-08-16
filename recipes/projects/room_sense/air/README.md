# HAZA Room Sense Air

> [!WARNING]
> **Disclaimer:** This project is being built one sensor at a time on real
> hardware. Treat the current YAML as a staged validation build, not the final
> Room Sense Air recipe.

`HAZA Room Sense Air` is the air-focused Room Sense variant.

The final direction is Room Sense Plus-style room sensing, but with particulate
matter added through an SPS30. We are bringing it up slowly: first the C6 board,
BH1750, and BME280; then SGP30; then SPS30; then movement and presence.

## Current Status

- YAML recipe: `esphome_room_sense_air_project.yaml`
- Board: ESP32-C6 Super Mini
- Current stage: BME280 bring-up
- Config validation: Passed on ESPHome `2026.7.3`
- Compile validation: Passed on ESPHome `2026.7.3`
- Physical validation: Pending staged BME280 upload and visual check
- Documentation approval: Draft, pending Pascal review

Full validation notes live in [validation.md](validation.md).

## Why Build This?

Room Sense Basic tells us how a room feels. Room Sense Plus adds indoor-air
signals with eCO2 and TVOC. Room Sense Air is where we start asking a sharper
question: what is actually floating around in the room?

The SPS30 stage will make this useful for dust, smoke, workshop air, cooking
effects, and ventilation experiments. The BME280 stage is first because it gives
us a clean C6 baseline with temperature, humidity, pressure, and dew point before
we add the larger sensor stack.

## Staged Build Plan

| Stage | Adds | Status |
| --- | --- | --- |
| 1 | ESP32-C6 Super Mini, BH1750, BME280 | Config and compile passed; hardware test pending |
| 2 | SGP30 eCO2 and TVOC | Planned |
| 3 | SPS30 particulate matter | Planned |
| 4 | PIR movement | Planned |
| 5 | HLK-LD2410C presence | Planned |

## Hardware And Bill Of Materials

| Item | Recommended Part | Image | Viable Alternatives | Notes |
| --- | --- | --- | --- | --- |
| Controller | ESP32-C6 Super Mini | To do: `assets/esp32-c6-super-mini.png` | Other ESP32-C6 boards | Pin mapping and board package may change. |
| Temperature, humidity, and pressure | BME280 module | To do: `assets/bme280-sensor.png` | BMP280 | BMP280 does not expose humidity and needs a different package. |
| Illuminance | BH1750 module | To do: `assets/bh1750-sensor.png` | Other ESPHome-supported lux sensors | Wiring and package will change. |
| eCO2 and TVOC | SGP30 module | To do | ENS160, CCS811 | Later stage. Alternatives need different packages and interpretation. |
| Particulate matter | SPS30 module | To do | PMSx003 family | Later stage. Wiring, airflow, and placement matter. |
| Movement | PIR sensor | To do | Other GPIO PIR modules | Later stage. |
| Presence | HLK-LD2410C | To do | Other LD2410 variants | Later stage. UART pins must match the build. |

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
| BH1750 | SDA | Board I2C SDA | Shared I2C bus from the C6 board package. |
| BH1750 | SCL | Board I2C SCL | Shared I2C bus from the C6 board package. |
| BME280 | VCC | 3V3 | Use 3.3V unless your module explicitly supports another voltage. |
| BME280 | GND | GND | Common ground with the ESP32-C6. |
| BME280 | SDA | Board I2C SDA | Shared I2C bus from the C6 board package. |
| BME280 | SCL | Board I2C SCL | Shared I2C bus from the C6 board package. |

Expected I2C addresses:

- BH1750: `0x23`
- BME280: `0x76`

## Framework Packages Used

- Board: `boards/esp32/c6_super_mini.yaml`
- Core: `common/core/settings.yaml`
- Time: `common/time/home_assistant.yaml`
- Network helpers: `common/network/wifi.yaml`
- Public recipe network: `common/network/wifi_dynamicip.yaml`
- Web server: `common/network/webserver.yaml`
- Sensor: `sensors/i2c/bh1750.yaml`
- Sensor: `sensors/i2c/bme280.yaml`

## Home Assistant Entities

Expected user-facing entities for the current stage:

- BME280 Temperature (C)
- BME280 Humidity
- BME280 Atmospheric Pressure
- BME280 Dew Point
- BH1750 Illuminance
- BH1750 Illuminance Human Readable
- Uptime
- IP Address
- Connected SSID
- Wifi Signal Strength

The exact entity IDs depend on the device substitutions used for the local
deployment.

## Screenshots And Visual Checks

To add during physical validation:

```text
[Image placeholder: ESPHome web server view for Room Sense Air stage 1]
[Image placeholder: Home Assistant device page for Room Sense Air stage 1]
[Image placeholder: close-up of the C6, BH1750, and BME280 wiring]
[Image placeholder: Fritzing wiring diagram]
```

## Validation Evidence

See [validation.md](validation.md).

## Troubleshooting

See [troubleshooting.md](troubleshooting.md).

## Change Notes

- 2026.0.0b: Created the staged Room Sense Air project with ESP32-C6, BH1750,
  and BME280.
