# HAZA Room Sense Motion

> [!WARNING]
> **Disclaimer:** This project is being built from a real wired Study device.
> It passed on that validation device, but it still carries the normal
> "it works in my environment" warning until more builds have repeated it.

`HAZA Room Sense Motion` is the PIR-only movement variant in the Room Sense
family.

It starts from the same comfortable-room baseline as Room Sense Basic: BME280
for temperature, humidity, pressure, and dew point, plus BH1750 for illuminance.
Then it adds a simple HC-SR501 PIR sensor for movement.

## Current Status

- YAML recipe: `esphome_room_sense_motion_project.yaml`
- Board: ESP32-C6 Super Mini for this validation device
- Likely future board: ESP32-C3 for a smaller PIR-focused build
- Current stage: C6 PIR hardware validation passed
- Config validation: Passed with ESPHome 2026.7.3
- Compile validation: Passed with ESPHome 2026.7.3 on 2026-08-17
- Physical validation: Passed with ESPHome 2026.7.4 on 2026-08-17
- Documentation approval: Draft, pending Pascal review

Full validation notes live in [validation.md](validation.md).

## Why Build This?

Room Sense Motion answers a simple question: did something move in the room?

That sounds basic, but it is useful. Motion can turn lights on, keep a room
active in Home Assistant, help decide whether a space is being used, or act as a
low-cost input for comfort automations.

This project deliberately stops at PIR. The LD2410C belongs in the later
Presence variant, where we can talk properly about still presence, UART wiring,
and the difference between movement and occupancy.

## Staged Build Plan

| Stage | Adds | Status |
| --- | --- | --- |
| 1 | ESP32-C6 Super Mini, BH1750, BME280, HC-SR501 PIR | Hardware validated on the C6 Study validation device |
| 2 | ESP32-C3 variant | Planned |
| 3 | LD2410C presence | Separate Presence project |

## Hardware And Bill Of Materials

| Item | Recommended Part | Image | Viable Alternatives | Notes |
| --- | --- | --- | --- | --- |
| Controller | ESP32-C6 Super Mini | To do: `assets/esp32-c6-super-mini.png` | ESP32-C3 Super Mini | The C6 is used here because the validation device is already wired. A C3 is probably enough for a PIR-focused build. |
| Temperature, humidity, and pressure | BME280 module | To do: `assets/bme280-sensor.png` | BMP280 | BMP280 does not expose humidity and needs a different package. |
| Illuminance | BH1750 module | To do: `assets/bh1750-sensor.png` | Other ESPHome-supported lux sensors | Wiring and package will change. |
| Movement | HC-SR501 PIR sensor | To do: `assets/hc-sr501-pir.png` | Other GPIO PIR modules | Delay and sensitivity are usually adjusted on the module itself. |

## Wiring

Pascal will provide the Fritzing diagram after the staged hardware check.

```text
[Image placeholder: assets/wiring-breadboard.png]
```

Current validation wiring:

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
| HC-SR501 | VCC | Module-safe supply | Check your PIR module voltage requirements. |
| HC-SR501 | GND | GND | Common ground with the ESP32-C6. |
| HC-SR501 | OUT | GPIO1 | Matches the previous Study wiring. |

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
- Binary sensor: `sensors/binary/hc_sr501.yaml`

## Home Assistant Entities

Expected user-facing entities for the current stage:

- BME280 Temperature (C)
- BME280 Humidity
- BME280 Atmospheric Pressure
- BME280 Dew Point
- BH1750 Illuminance
- BH1750 Illuminance Human Readable
- HC-SR501 Movement
- Uptime
- IP Address
- Connected SSID
- Wifi Signal Strength

The exact entity IDs depend on the device substitutions used for the local
deployment.

## Screenshots And Visual Checks

To add during documentation cleanup:

```text
[Image placeholder: ESPHome web server view for Room Sense Motion stage 1]
[Image placeholder: Home Assistant device page for Room Sense Motion stage 1]
[Image placeholder: close-up of the C6, BH1750, BME280, and PIR wiring]
[Image placeholder: Fritzing wiring diagram]
```

## Validation Evidence

See [validation.md](validation.md).

## Troubleshooting

See [troubleshooting.md](troubleshooting.md).

## Change Notes

- 2026-08-17: Created Room Sense Motion from the Room Sense Air project shape,
  removed SGP30 and SPS30, and added HC-SR501 PIR on `GPIO1`.
- 2026-08-17: Passed serial upload, log check, web check, and PIR movement
  on/off confirmation on the C6 Study validation device.
