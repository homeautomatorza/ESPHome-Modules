# HAZA SmartPad EM32 Smart Plug Troubleshooting

## Adoption Or API Fails

- Confirm whether the existing plug wrapper used `!secret api_encryption_key`.
- If the plug was previously paired without API encryption, Home Assistant may
  need re-adoption after the framework firmware is flashed.
- Do not guess or print the real key. Check the local secret name only.

## OTA Works But Rollback Is Not Available

- ESPHome reported that the dedicated SmartPad EM32 development plug bootloader
  is too old for OTA rollback.
- OTA can still succeed, but rollback support should not be assumed on the
  warranty-safe migration path.
- Keep this in mind before testing riskier builds remotely.

## Relay Does Not Switch

- Confirm the relay is still on GPIO4.
- Check whether relay restore mode is forcing the relay state on boot.
- Confirm the physical button toggles the relay before testing higher-level
  automations.

## LEDs Look Reversed

- The upstream config marks both LED outputs as inverted.
- Confirm GPIO6 for status LED and GPIO1 for relay LED on the development plug.

## Energy Values Look Wrong

- Start with a known load before changing calibration values.
- The initial values came from the upstream SmartPad EM32 config:
  `voltage_divider` `1518.4`, `current_resistor` `0.000948`, and
  `current_multiply` `0.868`.
- Keep calibration changes on the development plug until the readings are
  plausible.

## Bluetooth Proxy Is Unstable

- Test relay and metering without Bluetooth if the first combined build is
  unstable.
- The ESP32-C3 has limited resources, and the shared Bluetooth package already
  warns against combining Bluetooth with heavier features unless memory is
  acceptable.
- If needed, make Bluetooth a recipe-level option after the first hardware pass.
