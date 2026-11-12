# Room Sense Plus C6 Alt Troubleshooting

## A sensor is missing from the I²C scan

Expected addresses are SHT40 `0x44`, VEML7700 `0x10` and SGP40 `0x59`.
Check common ground, the 3.3 V sensor rail, SDA GPIO14 and SCL GPIO18 against
the [wiring table](../README.md#wiring). Confirm the actual breakout pin labels.

## VOC Index is NA after startup

Allow the SGP40 to complete startup stabilization. The description should show
“Waiting for VOC reading” until a valid index is available. Confirm the log
identifies SGP40 at `0x59` and names SHT40 temperature/humidity compensation.

## Infrared is zero

This output is calculated as `max(WHITE lux − ALS lux, 0)`. Zero is a valid
result when the WHITE reading does not exceed ALS; it is not a dedicated IR
power measurement or proof that all physical infrared is absent.

## Optional sensors are not visible in Home Assistant

SHT40 Fahrenheit, VEML7700 Full Spectrum and VEML7700 Infrared are disabled by
default. Enable the entities you want on the Home Assistant device page.

## Raw SHT40 readings appear twice in the web server

The web-server package includes internal sensors. The raw readings support the
named temperature/humidity outputs; they are not duplicate HA entities.
