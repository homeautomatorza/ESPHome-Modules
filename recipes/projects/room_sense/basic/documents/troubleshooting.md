# HAZA Room Sense Basic Troubleshooting

This page lists the first things to check when the Room Sense Basic build does
not behave as expected.

Start simple. Most early problems are wiring, power, secrets, names, or a stale
OTA password from old firmware.

## Device Does Not Boot

Check:

- USB cable and power source.
- 3.3V and GND are not swapped.
- SDA/SCL are not shorted.
- GPIO9 wiring is not preventing boot on the ESP32-C3 Super Mini.
- The board still boots with the I2C sensors disconnected.

GPIO9 is a strapping pin on the ESP32-C3 Super Mini. It worked in the validated
Room Sense Basic build, but it is still worth treating with care.

## I2C Sensors Are Not Found

Expected addresses:

- AHT20: `0x38`
- BH1750: `0x23`

Check:

- Both sensors are powered from 3.3V.
- All grounds are common.
- SDA goes to GPIO9.
- SCL goes to GPIO10.
- The sensor module actually uses the expected address.
- Only one sensor with the same fixed address is on the bus.

If one sensor appears and the other does not, move the missing sensor closer to
the board or test it by itself.

## Compile Fails

Check:

- ESPHome version is close to the validated version, `2026.7.3`.
- The package paths match where the YAML file lives.
- Your `secrets.yaml` contains the required keys.
- You did not mix dynamic-IP and fixed-IP substitutions without adding
  `device_ip_address`.

If ESPHome reports strange generated duplicate files, rebuild the local virtual
environment before assuming the YAML is broken.

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

## Web Server Does Not Open

Check:

- The device is on Wi-Fi.
- You are using the correct IP address or hostname.
- The web server username and password exist in `secrets.yaml`.
- Your browser is not using an old cached login.
- The device and browser are on networks that can reach each other.

## Home Assistant Does Not Show The Device

Check:

- The device is online and reachable from Home Assistant.
- The API encryption key in `secrets.yaml` matches what the device was compiled
  with.
- Home Assistant has discovered the device or it was added manually.
- The device name did not change unexpectedly during migration.

If the device was renamed, Home Assistant may retain old entities until the
device is cleaned up.

## Values Look Wrong

Check:

- The AHT20 is not enclosed with a heat source.
- The BH1750 is not pointed directly at a lamp unless that is intentional.
- The device has had a few minutes to settle after boot.
- Another room sensor agrees roughly with temperature and humidity.

For Basic, there is no project-specific calibration step yet.
