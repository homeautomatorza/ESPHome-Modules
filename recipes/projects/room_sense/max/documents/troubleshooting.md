# HAZA Room Sense Max Troubleshooting

This file collects practical checks for the combined Room Sense Max build.

Because Max combines the Air and Presence stacks, debug it one layer at a time:
power first, then I2C, then UART, then the derived text and occupancy sensors.

## Device Does Not Boot Or Keeps Restarting

Check:

- The ESP32-C6 board is powered from a stable supply.
- The SPS30 and LD2410C are not pulling the supply down during startup.
- Every sensor shares ground with the ESP32-C6.
- GPIO0 and GPIO4 wiring is not holding the board in an unwanted boot state.

## I2C Sensors Are Missing

Expected I2C addresses:

- BH1750: `0x23`
- SGP30: `0x58`
- SPS30: `0x69`
- BME280: `0x76`

Check:

- SDA and SCL match the ESP32-C6 board package wiring.
- All I2C modules share 3.3V-compatible logic.
- The BME280 is really a BME280, not a BMP280.
- The SGP30 and SPS30 are connected to the same I2C bus as the BH1750 and
  BME280.

## SGP30 Values Look Wrong

The SGP30 package uses BME280 humidity and temperature for compensation.

Check:

- `BME280 Humidity` has a valid value.
- `BME280 Temperature (C)` has a valid value.
- `SGP30 eCO2 Classification` and `SGP30 TVOC Level` update after the raw SGP30
  values update.
- The sensor has had time to settle after boot.

## SPS30 Values Stay Empty

Check:

- The SPS30 has power and a shared ground.
- The I2C address `0x69` appears in logs.
- The sensor has completed its warm-up period.
- Airflow around the SPS30 is not blocked.

If the SPS30 is present but slow to report values, give it a few minutes before
changing the YAML.

## PIR Does Not Change State

Check:

- The PIR `OUT` pin is connected to `GPIO1`.
- The PIR has power and a shared ground with the ESP32-C6.
- The PIR module voltage is suitable for the way it is powered.
- The sensitivity and delay trim pots are not set to awkward extremes.
- The sensor has had a short warm-up period after boot.

## LD2410C Does Not Show Values

Check:

- The LD2410C has power and a shared ground with the ESP32-C6.
- The UART pins are crossed correctly:
  - ESP32-C6 TX `GPIO3` goes to LD2410C RX.
  - ESP32-C6 RX `GPIO4` comes from LD2410C TX.
- The UART baud rate is `256000`.
- The package variable `uart_port` matches the local UART id:
  `${device_internal_name}_uart_bus1`.

If the UART wiring is swapped or the baud rate is wrong, the GPIO presence pin
may still change, but the LD2410C distance, energy, and target entities will
not behave properly.

## Room Occupancy Looks Wrong

`Room Occupancy` is true when either of these is true:

- `HC-SR501 Movement`
- `LD2410 GPIO Presence`

If occupancy stays true, check which source entity is still true. PIR delay
settings can hold movement on for a while. LD2410C can also remain true if the
sensor still sees a target, even when the person is sitting still.

If occupancy stays false, check both source entities before debugging the
template.

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
