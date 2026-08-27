# HAZA Room Sense Plus Troubleshooting

This page lists the first things to check when the Room Sense Plus build does
not behave as expected.

Room Sense Plus uses the same base checks as Room Sense Basic, then adds ENS160
specific checks for eCO2, TVOC, and air quality readings.

## Device Does Not Boot

Check:

- USB cable and power source.
- 3.3V and GND are not swapped.
- SDA/SCL are not shorted.
- GPIO9 wiring is not preventing boot on the ESP32-C3 Super Mini.
- The board still boots with the I2C sensors disconnected.

GPIO9 is a strapping pin on the ESP32-C3 Super Mini. Treat it with care and
check boot behavior after wiring changes.

## I2C Sensors Are Not Found

Expected addresses:

- BH1750: `0x23`
- AHT20: `0x38`
- ENS160: `0x53`

Check:

- All sensors are powered from 3.3V.
- All grounds are common.
- SDA goes to GPIO9.
- SCL goes to GPIO10.
- The ENS160 module actually uses address `0x53`.
- Only one device with the same fixed address is on the bus.

If one sensor appears and the others do not, test the missing sensor by itself
before blaming the shared package.

## Compile Fails

Check:

- ESPHome version is close to the validated target, `2026.7.3`.
- The package paths match where the YAML file lives.
- Your `secrets.yaml` contains the required keys.
- You did not mix dynamic-IP and fixed-IP substitutions without adding
  `device_ip_address`.

## ENS160 Values Look Wrong

Check:

- The ENS160 has had time to settle after boot.
- The sensor is not trapped in a sealed enclosure.
- The sensor is not directly beside heat, solvent, cleaning products, or strong
  airflow unless that is the thing you are testing.
- The values are treated as indoor-air indicators, not lab-grade measurements.

The ENS160 package still needs physical validation in this project, so treat
unexpected readings as evidence to investigate rather than as a finished claim.

## OTA Upload Asks For A Password

If the log says:

```text
ERROR ESP requests password, but no password given!
```

the firmware currently running on the device is asking for an OTA password. The
API encryption key is not the same thing as the OTA password.

Fix options:

- Add the existing OTA password to the migration build.
- Use the ESPHome web-server OTA path if the old firmware supports it.
- Flash once over USB/serial.

## Home Assistant Does Not Show The Device

Check:

- The device is online and reachable from Home Assistant.
- The API encryption key in `secrets.yaml` matches what the device was compiled
  with.
- Home Assistant has discovered the device or it was added manually.
- The device name did not change unexpectedly during migration.
