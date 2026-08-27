# HAZA Weather Sense Air Troubleshooting

This file collects practical checks for the Weather Sense Air stage.

## Start With The Shared Bus

Most of this variant depends on the I2C bus. If the device boots but sensors are
missing, check the bus first:

- BME280 on I2C `GPIO21`/`GPIO22`, expected address `0x76`
- LTR390 on I2C `GPIO21`/`GPIO22`, expected address `0x53`
- CCS811 on I2C `GPIO21`/`GPIO22`, expected address `0x5A`
- Common 3V3 and GND
- Pull-ups on the I2C lines if the modules or board do not already provide them

## CCS811 Is Missing

Check:

- The sensor is powered from the correct voltage for that module.
- SDA is connected to `GPIO21`.
- SCL is connected to `GPIO22`.
- The I2C scan shows `0x5A`.
- The module is not held in reset or wake mode by a floating pin.
- The device has been running long enough for first readings to appear.

If the scan does not show `0x5A`, treat it as wiring, power, address, or module
selection first. The YAML can compile even when the physical sensor is absent.

## CCS811 Shows Waiting For Data

The human-readable labels intentionally show `Waiting For Data` until the raw
sensor publishes a valid value. Give the sensor a short startup window, then
check logs for CCS811 setup or read errors.

## LTR390 Is Missing

Check:

- The sensor is fitted to this board. This Weather Sense hardware uses LTR390,
  not BH1750.
- The I2C scan shows `0x53`.
- SDA and SCL are on the shared I2C bus.
- The module voltage matches the board wiring.

## Wind Or Rain Fields Are Missing

That is expected for Weather Sense Air. Wind and rain are not part of this
variant anymore; they belong to the future V4 weather-meter path.

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
