# HAZA SmartPad EM32 Smart Plug

> [!WARNING]
> **Disclaimer:** These files are shared as-is, with the usual "it works in my
> environment" honesty baked in. They come from real builds, test
> devices, and ongoing experiments, but they are not guaranteed to work safely
> or correctly in your setup. Check the code, wiring, pins, power, secrets,
> calibration, and local rules and regulations before using anything. If it can
> switch mains power, move water, open a gate, affect safety, or ruin your
> afternoon, test it properly first.

`HAZA SmartPad EM32 Smart Plug` is the first framework migration scaffold for
the SmartPad EM32 ESP32-C3 energy-monitoring plug.

The goal is to stop depending on
`github://Smartpadza/Device_Configs/smartpad-em32-smart-plug.yaml` and keep the
device-specific logic inside this recipe while the standard HAZA packages handle
the board, core services, network, web server, and Bluetooth proxy stack.

## Current Status

- YAML recipe: `esphome_smartpad_em32_smart_plug_project.yaml`
- Project-local package: `packages/em32_smart_plug.yaml`
- Config validation: Passed on ESPHome `2026.8.1`
- Compile validation: Passed on ESPHome `2026.8.1`
- OTA push: Passed on a dedicated SmartPad EM32 development plug
- API/log check: Passed; the migrated firmware connected and reported the HAZA
  project metadata
- Web UI check: Passed; the ESPHome web server loaded and showed live entities
- Function tests still pending: relay action, physical button, LEDs, energy
  values against a known load, overload cutoff, and longer Bluetooth stability
- API encryption: the development plug works with the shared
  `!secret api_encryption_key`

Full validation notes live in [validation.md](validation.md).

## Why Build This?

If the framework can own the firmware cleanly, these plugs can do more than
switch loads and measure energy: they can also help with Bluetooth proxy and BLE
tracking coverage without adding more hardware.

The first validation unit kept its existing ESPHome-safe hostname and friendly
name during migration so the firmware change could be tested without changing
the device identity at the same time.

## What This Project Does

The device exposes:

- relay outlet switch
- physical power button
- voltage, current, power, energy, and daily energy sensors
- calibration controls for voltage divider, current resistor, and current
  multiplier
- overload count diagnostic sensor
- standard framework Wi-Fi, API, OTA, web server, uptime, status, and diagnostic
  entities
- Bluetooth proxy and BLE tracker entities from the shared framework package

## Migration Notes

- The board uses `boards/esp32/c3_basic.yaml`.
- The SmartPad-specific pins and BL0937 configuration live in
  `packages/em32_smart_plug.yaml`.
- The upstream `dashboard_import` entry has not been carried forward.
- The upstream naked `api:` block has been replaced by the shared framework core
  package, which uses `!secret api_encryption_key`.
- Local Desktop App wrappers found during investigation already add
  `api.encryption.key: !secret api_encryption_key` around the upstream SmartPad
  package. The first dedicated development plug confirmed that path for the
  migration build. Each additional plug should still be confirmed before
  migration.
- Bluetooth proxy is included now because it is one of the reasons for migrating
  these plugs. If memory, Wi-Fi stability, or relay/energy behavior suffers, it
  should be the first optional feature to test separately.
- ESPHome reported that the plug bootloader is too old for OTA rollback. OTA
  still worked, but rollback support is not available on this warranty-safe
  migration path.

## Hardware Pin Map To Confirm

| Function | GPIO | Source |
| --- | --- | --- |
| Relay | GPIO4 | Upstream SmartPad EM32 YAML |
| Relay LED | GPIO1 | Upstream SmartPad EM32 YAML |
| Status LED | GPIO6 | Upstream SmartPad EM32 YAML |
| Power button | GPIO20 | Upstream SmartPad EM32 YAML |
| BL0937 CF | GPIO7 | Upstream SmartPad EM32 YAML |
| BL0937 CF1 | GPIO3 | Upstream SmartPad EM32 YAML |
| BL0937 SEL | GPIO5, inverted | Upstream SmartPad EM32 YAML |

## Open Questions For Hardware Testing

- Does the development plug adopt cleanly with the shared
  `api_encryption_key`, or does it need a one-time migration path?
- Does relay restore mode behave as expected after reboot and power loss?
- Are voltage, current, power, and daily energy values plausible with a known
  load?
- Does overload cutoff work safely with a controlled test load?
- Does Bluetooth proxy remain stable on the ESP32-C3 when the web server and
  energy monitoring are also enabled?
- Should a dedicated SmartPad board package exist later, or is `c3_basic.yaml`
  still the right neutral board layer?

## Setup

1. Review the substitutions in the recipe YAML.
2. Confirm your `secrets.yaml` contains the framework secrets used by the shared
   packages.
3. Run ESPHome config validation.
4. Run ESPHome compile validation.
5. Flash only the dedicated development unit first.
6. Check relay, button, LEDs, metering, API adoption, and Bluetooth proxy before
   migrating other plugs.
