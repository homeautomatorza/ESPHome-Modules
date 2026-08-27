# HAZA Weather Sense Wind and Rain Troubleshooting

This file collects practical checks for the Weather Sense Wind and Rain stage.

## Start With Wind

If the device does not boot or the baseline readings are missing, troubleshoot
Weather Sense Wind first:

- BME280 on I2C `GPIO21`/`GPIO22`
- LTR390 on I2C `GPIO21`/`GPIO22`
- DS18B20 on `GPIO4`
- Battery divider on `GPIO33`
- Anemometer on `GPIO14`
- Wind vane on `GPIO35`

Rain is easier to debug once the already-tested wind stage is stable.

## Rainfall Does Not Change

Check:

- The rain gauge signal is connected to `GPIO25`.
- The rain gauge switch closes between signal and ground.
- The sensor ground is common with the ESP32.
- The bucket mechanism can tip freely.
- The package is using `INPUT_PULLUP` and falling-edge counting.
- Logs do not show pulse counter setup errors.

For bench testing, manually tipping the bucket should be enough to prove that
pulses are being counted.

## Total Rainfall Does Not Increment

Check:

- `Rainfall Rate` changes during a manual tip test.
- `Total Rainfall` is visible in the web server or Home Assistant.
- The bucket is not tipping too quickly for the configured filter.
- The device was not rebooted between tips if you are watching the total value.

The current total is since boot/reset. Daily or long-term rain totals are better
handled in Home Assistant once the raw hardware behaviour is proven.

## Rainfall Looks Too High

Check:

- The bucket switch is not bouncing.
- The bucket mechanism is not vibrating in wind.
- `rain_gauge_internal_filter` is not too short.
- The calibration value `rain_gauge_tip_mm` matches the actual rain gauge.

The default `rain_gauge_tip_mm` is `0.2794`, which is the SparkFun-style weather
meter starting point. Treat it as a calibration value, not a law of nature.

## Rainfall Looks Too Low

Check:

- The bucket is tipping fully.
- The reed switch actually closes on each tip.
- The input is not wired to the wrong GPIO.
- `rain_gauge_internal_filter` is not so long that it ignores valid tips.

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
