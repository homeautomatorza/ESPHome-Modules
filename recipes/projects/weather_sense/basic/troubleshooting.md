# HAZA Weather Sense Basic Troubleshooting

This file collects practical checks for the first modular Weather Sense build.

## Device Does Not Boot

Check the simple things first:

- The ESP32 board is powered from USB while bench testing.
- The solar and battery wiring is not back-feeding the USB supply.
- The board still boots with the external sensors disconnected.
- The battery voltage divider is not connected to the wrong pin.

## I2C Sensors Are Not Found

Expected I2C addresses for Basic:

- BME280: `0x76`
- LTR390: `0x53`

If one is missing:

- Check SDA on `GPIO21`.
- Check SCL on `GPIO22`.
- Check 3.3V and GND.
- Test one I2C module at a time.
- Confirm the BME280 board is really BME280 and not BMP280 if humidity is
  missing.

## DS18B20 Does Not Report Temperature

Check:

- The probe data wire is on `GPIO4`.
- The 1-Wire pull-up is fitted where the hardware expects it.
- The configured `ds18b20_address` matches the actual probe address.
- ESPHome logs show the discovered 1-Wire address after boot.

If the probe was replaced, update the substitution before treating the package
as broken.

## Battery Value Looks Wrong

Battery percentage is only as good as the voltage divider calibration.

Check:

- Measure the battery with a multimeter.
- Compare the multimeter value to `Battery Voltage`.
- Update `battery_empty_voltage` and `battery_full_voltage` for the real
  divider output.
- Do not assume the ESPHome ADC value is the raw cell voltage unless the circuit
  was designed that way.

## Sun Values Look Wrong

The public recipe uses placeholder coordinates.

Set:

- `location_latitude`
- `location_longitude`

Use your own location in the private deployment file, not in the public recipe.

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
