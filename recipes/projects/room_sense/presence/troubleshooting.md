# HAZA Room Sense Presence Troubleshooting

This file collects practical checks for the staged Room Sense Presence build.
It includes the Room Sense Motion checks, then adds LD2410C UART and presence
checks.

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

## LD2410C Does Not Show Values

Check:

- The LD2410C has power and a shared ground with the ESP32-C6.
- The UART pins are crossed correctly:
  - ESP32-C6 TX `GPIO3` goes to LD2410C RX.
  - ESP32-C6 RX `GPIO4` comes from LD2410C TX.
- The UART baud rate is `256000`.
- The project includes `sensors/uart/hlk_ld2410c_minimal.yaml`.
- The package variable `uart_port` matches the local UART id:
  `${device_internal_name}_uart_bus1`.

If the UART wiring is swapped or the baud rate is wrong, the GPIO presence pin
may still change, but the LD2410C distance, energy, and target entities will
not behave properly.

## LD2410C GPIO Presence Does Not Change

Check:

- The LD2410C `OUT` pin is connected to `GPIO0`.
- GPIO0 is not being pulled into an unwanted boot state by the module or wiring.
- The module has completed its warm-up period.
- The detection gates and sensitivity have not been configured too narrowly.

## Room Occupancy Looks Wrong

`Room Occupancy` is true when either of these is true:

- `HC-SR501 Movement`
- `LD2410 GPIO Presence`

If occupancy stays true, check which source entity is still true. PIR delay
settings can hold movement on for a while. LD2410C can also remain true if the
sensor still sees a target, even when the person is sitting still.

If occupancy stays false, check both source entities before debugging the
template. The combined sensor cannot become true unless one of the two source
sensors has changed state.

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
