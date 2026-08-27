# HAZA Room Sense Air Troubleshooting

This file collects practical checks for the staged Room Sense Air build.

## BME280 Does Not Show Values

Check:

- The module is a BME280, not a BMP280.
- The I2C address matches the YAML. The staged recipe uses `0x76`.
- Power is 3.3V unless your module explicitly supports another voltage.
- SDA and SCL match the ESP32-C6 board package wiring.
- Ground is shared between the ESP32-C6 and the sensor module.

## Web Server Shows Waiting For Data

`Waiting For Data` means the text sensor has not yet received its first valid
source value. Give the device a short moment after boot.

If the value stays there:

- check the ESPHome logs
- confirm the sensor appears on the I2C bus
- confirm the expected I2C address
- check wiring and power

## Pressure Looks Wrong

BME280 pressure is local atmospheric pressure. It will not exactly match a
weather-service sea-level pressure reading unless corrected for altitude.
