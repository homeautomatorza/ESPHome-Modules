# HAZA SmartPad EM32 Smart Plug Validation

This page records validation evidence for the SmartPad EM32 framework
migration.

Config and compile checks matter, but they are not physical hardware tests.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Source inspection | Passed | Public upstream YAML, local SmartPad wrapper/package material, and live Desktop App config inspected, 2026-08-26. |
| Config validation | Passed | ESPHome `2026.8.1` accepted the recipe YAML, 2026-08-26. |
| Compile validation | Passed | ESPHome `2026.8.1` produced firmware from a temporary validation copy, 2026-08-26. |
| Desktop App local wrapper | Passed | A private Desktop App wrapper accepted and compiled against the temporary local project copy, 2026-08-26. |
| Physical OTA upload | Passed | Pascal OTA-pushed the migrated framework firmware to a dedicated SmartPad EM32 development plug, 2026-08-26. |
| API/log check | Passed | ESPHome logs connected, completed the encrypted API handshake, and reported project `haza.smartpad_em32_smart_plug` version `2026.0.0a`, 2026-08-26. |
| Web UI check | Passed | ESPHome web UI loaded at the device hostname and showed live control, diagnostic, Wi-Fi, and BLE entities, 2026-08-26. |
| Live relay/button/LED test | Not run | Needs hardware. |
| Live energy metering test | Not run | Needs hardware and a known load. |
| Bluetooth proxy runtime smoke test | Passed | Logs reported Bluetooth proxy active, BLE tracker running, and BLE scanner values publishing, 2026-08-26. |
| Bluetooth proxy stability test | Not run | Needs longer runtime and Home Assistant observation. |

## Source Evidence

Public upstream source:

```text
github://Smartpadza/Device_Configs/smartpad-em32-smart-plug.yaml
```

Private local evidence inspected:

```text
Desktop App wrapper for the development plug
Archived original Desktop App wrapper
Older local SmartPad EM32 wrappers
Private workbench SmartPad EM32 package
```

The live Desktop App device config compiled and uploaded in its current form
before this migration pass. It was archived unchanged before the framework
migration wrapper was tested.

The live config is intentionally small. It uses the upstream SmartPad package,
the existing device identity, normal Wi-Fi secrets, and:

```yaml
api:
  encryption:
    key: !secret api_encryption_key
```

That supports using the shared framework API key as the first migration attempt,
but it does not prove every physical plug is already paired and recoverable with
that key.

On 2026-08-26, the live Desktop App wrapper was migrated to a temporary local
framework package copy.

The live wrapper now keeps the same hostname and friendly name, but pulls the
SmartPad framework migration from that local folder instead of the upstream
SmartPad GitHub package. This is a testing step only; it is not a GitHub
deployment and it is not final hardware proof.

## Automated Validation

Local recipe file:

```text
recipes/projects/smartpad/em32_smart_plug/esphome_smartpad_em32_smart_plug_project.yaml
```

Validated with:

```text
ESPHome 2026.8.1
```

Results:

- Config validation passed with dummy placeholder secrets.
- Compile validation passed with dummy placeholder secrets.
- Firmware artifacts were produced in a temporary validation copy.
- Firmware size: `0x17e180` bytes.
- Smallest app partition: `0x1c0000` bytes.
- Free app partition space: `0x41e80` bytes, about 15%.
- ESP-IDF size summary: RAM `44.2%`, flash `85.3%`.

## Physical OTA, Log, And Web Smoke Test

Date:

```text
2026-08-26
```

Device:

```text
Dedicated SmartPad EM32 development plug
```

Evidence supplied by Pascal:

- OTA push: Passed.
- Compile before OTA: Passed.
- ESPHome log check: Passed.
- ESPHome web UI check: Passed.

Sanitized log evidence:

- ESPHome logs connected to the migrated device through the native API.
- The encrypted API handshake completed.
- The firmware reported ESPHome `2026.8.1`.
- The firmware reported project `haza.smartpad_em32_smart_plug` version
  `2026.0.0a`.
- The device identified as an ESP32-C3.
- Wi-Fi was connected.
- The web server, OTA endpoint, API endpoint, mDNS, safe mode, captive portal,
  relay switch, power button, HLW8012/BL0937 metering sensors, total daily
  energy sensor, Wi-Fi diagnostics, Bluetooth proxy, BLE tracker, and BLE
  scanner components were present in the runtime component dump.
- Bluetooth proxy reported active with three connection slots.
- BLE tracker reported active scanning.
- BLE scanner text sensor published nearby BLE device observations.
- Wi-Fi signal diagnostics published values and a human-readable strength
  label.
- Energy, total energy, and power entities published initial idle values.

Sanitized web evidence:

- The ESPHome web UI loaded from the device hostname.
- The page showed the dedicated development plug running the SmartPad EM32
  framework migration build.
- Sensor/control, configuration, diagnostic, Wi-Fi diagnostic, and BLE scanner
  rows were visible.
- The relay switch control, power-on-state selector, calibration numbers,
  version/config-hash text sensor, uptime, Wi-Fi diagnostics, BLE scanner, and
  metering entities were visible.

Privacy note:

- The source log and screenshot included private network details, MAC
  addresses, local IPs, Wi-Fi names, and BLE addresses. Those values are not
  copied into this public validation note.

Known warning:

- ESPHome reported that the bootloader is too old for OTA rollback. The OTA
  push still succeeded, but rollback support should not be assumed for this
  plug. USB flashing is not part of this migration path because it would void
  the warranty.

Validation environment note:

- Earlier compile validation exposed duplicate `* 2.*` files in the installed
  `esphome` package. Those duplicates were removed from the venv on
  2026-08-26.
- A direct compile using the cleaned local ESPHome environment passed after
  cleanup, without the temporary package-copy workaround.

Desktop App validation after live wrapper migration:

```text
esphome config <private-development-wrapper>.yaml
esphome compile <private-development-wrapper>.yaml
```

Run from:

```text
Private ESPHome Desktop App workspace
```

Results:

- Config validation passed with Pascal's existing Desktop App secrets.
- Compile validation passed.
- Firmware binary size: `0x17e220` bytes.
- Smallest app partition: `0x1c0000` bytes.
- Free app partition space: `0x41de0` bytes, about 15%.
- ESP-IDF size summary: RAM `44.2%`, flash `85.3%`.

## Validated Package Stack

Target package stack for the first framework build:

- `boards/esp32/c3_basic.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `common/network/bluetooth.yaml`
- `recipes/projects/smartpad/em32_smart_plug/packages/em32_smart_plug.yaml`

## Checks Still Needed

Run from the repository root when the ESPHome environment is healthy:

```text
.venv/bin/esphome config recipes/projects/smartpad/em32_smart_plug/esphome_smartpad_em32_smart_plug_project.yaml
.venv/bin/esphome compile recipes/projects/smartpad/em32_smart_plug/esphome_smartpad_em32_smart_plug_project.yaml
```

Hardware validation should stay limited to the dedicated development unit until
these remaining function tests pass:

- relay switching from Home Assistant
- physical button short press
- relay LED and status LED behavior
- voltage, current, power, and energy values against a known load
- overload cutoff behavior with a controlled safe test
- Bluetooth proxy and BLE tracking stability over time
