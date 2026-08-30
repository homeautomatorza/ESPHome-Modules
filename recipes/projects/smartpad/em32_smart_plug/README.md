# HAZA SmartPad EM32 Smart Plug

> [!WARNING]
> **Disclaimer:** These files are shared as-is, with the usual "it works in my
> environment" honesty baked in. They come from real builds, test
> devices, and ongoing experiments, but they are not guaranteed to work safely
> or correctly in your setup. Check the code, wiring, pins, power, secrets,
> calibration, and local rules and regulations before using anything. If it can
> switch mains power, move water, open a gate, affect safety, or ruin your
> afternoon, test it properly first.

`HAZA SmartPad EM32 Smart Plug` is the first framework migration project for
the SmartPad EM32 ESP32-C3 energy-monitoring plug.

The goal is to stop depending on
`github://Smartpadza/Device_Configs/smartpad-em32-smart-plug.yaml` and keep the
device-specific logic inside this recipe while the standard HAZA packages handle
the board, core services, network, web server, and Bluetooth proxy stack.

<details>

<summary><b>Current Status</b></summary><br>

- YAML recipe: `esphome_smartpad_em32_smart_plug_project.yaml`
- Project-local package: `packages/em32_smart_plug.yaml`
- Config validation: Passed on ESPHome `2026.8.1`
- Compile validation: Passed on ESPHome `2026.8.1`
- OTA push: Passed on the `Watt the Actual` development plug
- API/log check: Passed; the migrated firmware connected and reported the HAZA
  project metadata
- Web UI check: Passed; the ESPHome web server loaded and showed live entities
- Function tests still pending: relay action, physical button, LEDs, energy
  values against a known load, overload cutoff, and longer Bluetooth stability
- API encryption: the development plug works with the shared
  `!secret api_encryption_key`

Full validation notes live in [validation.md](documents/validation.md).

</details>

## Project Profile

| Factor | Rating | Notes |
| --- | --- | --- |
| Difficulty | Advanced | This is a mains-powered commercial device with device-specific firmware and calibration. |
| Estimated cost | Medium | The complete smart plug includes switching, metering, and an ESP32-C3. |
| Build time | 1-2 hours for firmware migration | Functional and calibration testing takes longer. |
| Tools needed | Safe test load and electrical measurement gear | Do not open or probe the mains side unless you are qualified and equipped to do so safely. |
| Off-the-shelf viability | Better to buy | This project adapts an existing product; it is not a from-scratch mains build. |
| Maintenance burden | Medium | Firmware, metering calibration, relay behaviour, and BLE stability need checking. |

## Why Build This?

Pascal already has several of these plugs around the house. If the framework can
own the firmware cleanly, the plugs can do more than switch loads and measure
energy: they can also help with Bluetooth proxy and BLE tracking coverage
without adding more hardware.

The first development unit uses the friendly name `Watt the Actual` and the
ESPHome-safe hostname `watt-the-actual`.

## What Problems It Solves

- Brings the SmartPad EM32 firmware into the local modular framework.
- Keeps relay, button, LEDs, and energy monitoring in one device-specific package.
- Adds local diagnostics, web access, and Bluetooth proxy coverage without another ESP32.
- Removes the runtime dependency on the upstream remote package.

## What Possibilities It Creates

- Repeatable migration of additional EM32 plugs after the function tests pass.
- Local energy history and load-aware Home Assistant automations.
- Wider BLE coverage from hardware that is already powered around the home.
- A future reusable SmartPad board layer if testing proves that abstraction useful.

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
  package. The `Watt the Actual` development plug has now confirmed that path
  for the first migration build. Each additional plug should still be confirmed
  before migration.
- Bluetooth proxy is included now because it is one of the reasons for migrating
  these plugs. If memory, Wi-Fi stability, or relay/energy behavior suffers, it
  should be the first optional feature to test separately.
- ESPHome reported that the plug bootloader is too old for OTA rollback. OTA
  still worked, but rollback support is not available on this warranty-safe
  migration path.

## Hardware And Bill Of Materials

| Item | Recommended Part | Image | Alternates |
| --- | --- | --- | --- |
| Smart plug | SmartPad EM32 ESP32-C3 energy-monitoring smart plug | Pending project photo | Use only hardware with a separately verified pin map and metering configuration. |
| Firmware connection | Existing supported OTA path | Not applicable | A manufacturer-supported serial method, used only by someone qualified to access it. |
| Test load | Known, controlled load within the plug rating | Not applicable | Start with a low-risk load suitable for checking switching and plausible metering. |
| Measurement reference | Suitable electrical meter or known-load reference | Not applicable | Required before claiming metering accuracy. |

> [!WARNING]
> This is mains-powered hardware. Do not treat another plug as a drop-in
> replacement, guess its GPIO map, bypass its enclosure, or connect a serial
> adapter to an energised device. Check the exact model, rating, firmware path,
> local regulations, and safe isolation method first.

## Who This Is For

Use this project if you already own the exact SmartPad EM32 model, understand
the risks of changing commercial mains firmware, and can test it with a
controlled load. Buy or retain supported stock firmware if you need a certified,
maintenance-free appliance rather than an experimental local integration.

## Wiring

There is no external low-voltage wiring step for normal use. The GPIO map below
documents the firmware contract inherited from the upstream SmartPad config; it
is not an instruction to open or rewire the plug.

> [!WARNING]
> Never work on the plug while it is connected to mains power. Do not open the
> enclosure or probe internal pads unless you are qualified, have a safe
> isolation procedure, and understand the legal and electrical risks.

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

<details>

<summary><b>Framework Packages Used</b></summary><br>

- Board: `boards/esp32/c3_basic.yaml`
- Core: `common/core/settings.yaml`
- Time: `common/time/home_assistant.yaml`
- Network helpers: `common/network/wifi.yaml`
- Public recipe network: `common/network/wifi_dynamicip.yaml`
- Web server: `common/network/webserver.yaml`
- Bluetooth proxy and tracker: `common/network/bluetooth.yaml`
- Project-local device package: `packages/em32_smart_plug.yaml`

</details>

## Visual Checks

Still to capture for the project documentation:

```text
[Image placeholder: ESPHome web server with relay, metering, and BLE entities]
[Image placeholder: Home Assistant device page]
[Image placeholder: external product photo showing the exact SmartPad EM32 model]
```

## Home Assistant Entities

<details>

<summary><b>Expected user-facing entities</b></summary><br>

- Outlet switch and physical power-button state
- Voltage, current, power, energy, and daily energy
- Power On State selector
- Voltage Divider, Current Resistor, and Current Multiplier configuration entities
- Overload Count diagnostic
- Standard status, uptime, network, web, and Bluetooth entities

The exact entity IDs depend on the device substitutions used for the local
deployment.

</details>

## Calibration And Tuning

Do not assume the inherited metering constants are accurate for every unit.
Compare voltage, current, and power against suitable reference equipment and a
known controlled load. Overload cutoff and calibration remain pending function
tests on this migration.

## Validation Evidence

See [validation.md](documents/validation.md).

## Troubleshooting

See [troubleshooting.md](documents/troubleshooting.md).

## Changelog

See [changelog.md](documents/changelog.md).

## Related Projects And Next Variants

- Additional SmartPad EM32 units should wait until relay, button, LED, metering, overload, and BLE tests pass on the development plug.
- A reusable SmartPad board package remains a later decision, not a current requirement.
