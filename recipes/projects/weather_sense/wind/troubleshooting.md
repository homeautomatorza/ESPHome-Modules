# HAZA Weather Sense Wind Troubleshooting

This file collects practical checks for the Weather Sense Wind stage.

## Start With Basic

If the device does not boot or the baseline readings are missing, troubleshoot
Weather Sense Basic first:

- BME280 on I2C `GPIO21`/`GPIO22`
- LTR390 on I2C `GPIO21`/`GPIO22`
- DS18B20 on `GPIO4`
- Battery divider on `GPIO33`

Wind is easier to debug once the quiet baseline is stable.

## Wind Speed Does Not Change

Check:

- The anemometer signal is connected to `GPIO14`.
- The anemometer has the pull-up or module wiring it expects.
- The sensor ground is common with the ESP32.
- The cups are actually spinning during the test.
- Logs do not show pulse counter setup errors.

For bench testing, a gentle fan or manual spin is enough to prove that pulses
are being counted. Do not treat the value as calibrated yet.

## Beaufort Scale Does Not Update

Check:

- `Wind Speed (KPH)` is changing first.
- The average wind speed helper has had enough time to update.
- The web server is refreshed after the average changes.

The Beaufort helper depends on the wind speed package. If wind speed is stuck at
zero, fix that first.

## Wind Direction Is Wrong Or Blank

Check:

- The wind vane ADC output is connected to `GPIO35`.
- The resistor ladder has the expected 10 kOhm downstream reference.
- The vane has power and common ground if your module needs it.
- The vane is not between positions during the test.

If the direction is consistently wrong, capture the raw resistance value for
each physical vane position and tune the package ranges.

## ADC Values Look Strange

Check:

- The voltage at `GPIO35` never exceeds the ESP32 ADC input limit.
- The resistor ladder is wired the same way the package expects.
- The weather station board is using the same ADC path as the historical flat
  YAML.

## Web Server Does Not Open

Check:

- The device has joined WiFi.
- The IP address appears in logs or Home Assistant.
- The web server username and password exist in `secrets.yaml`.
- The browser is on a network that can reach the ESPHome device.

## Home Assistant Does Not Show The Device

Check:

- The API encryption key in `secrets.yaml` matches what the device was compiled
  with.
- Home Assistant can reach the device network.
- The device is not stuck in fallback AP mode.
- mDNS is working, or use the IP address for first adoption.
