# HAZA Room Sense Motion Troubleshooting

This file collects practical checks for the staged Room Sense Motion build.

## PIR Does Not Change State

Check:

- The PIR `OUT` pin is connected to `GPIO1`.
- The PIR has power and a shared ground with the ESP32-C6.
- The PIR module voltage is suitable for the way it is powered.
- The sensitivity and delay trim pots are not set to awkward extremes.
- The sensor has had a short warm-up period after boot.

Most PIR modules are deliberately slow compared with a push button. Give the
sensor a moment between movement tests.

## PIR Stays On

Check:

- The delay trim pot on the PIR module.
- Whether the sensor is pointing at moving air, sunlight, a heater, or another
  changing heat source.
- Whether the output pin is floating because the module ground is not shared
  with the ESP32-C6.

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
