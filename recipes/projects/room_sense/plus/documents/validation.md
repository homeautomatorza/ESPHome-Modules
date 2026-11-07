# Room Sense Plus Validation

This page records validation evidence for the Room Sense Plus project.

Room Sense Plus starts from the hardware-validated Room Sense Basic package
stack and adds the ENS160 VOC, eCO2, and air quality sensor. The ENS160 path
has been physically checked on a private validation device. Its updated
ESPHome web-server and Home Assistant screenshots are saved below;
the C3/ENS160 documentation was approved by Pascal on `2026-11-07`.

An SGP30 alternate is also available. It uses the validated Room Sense Air Stage
2 stack: ESP32-C6 Super Mini, BME280, BH1750, and SGP30.

## Maintenance Boundary

Pascal marked the C3/ENS160 version complete and frozen on `2026-11-07`.
Future ESPHome validation checks and their results may be recorded. Changes
to hardware, wiring, features, behaviour or the pinned packages require Pascal
to reopen this release. The C6/SGP30 alternate is not covered by this approval.

The changelog's `1.0.0` is the approved documentation release. The recipe file
revision is `2026.0.1`; its runtime project metadata remains `2026.0.0`, as
shown in the production proof. This release changes package references to an
immutable tested revision without changing its sensor logic or pin mapping.

## Summary

| Layer | Status | Evidence |
| --- | --- | --- |
| Config validation | Passed | ESPHome `2026.7.3` historical pass; final frozen C3 recipe passed on ESPHome `2026.10.0` on `2026-11-07`. |
| Compile validation | Passed | ESPHome `2026.7.3` produced firmware; Pascal also reported local compile pass on `2026-08-16`. |
| Physical upload | Passed | Pascal reported OTA passes on `2026-08-16` and `2026-11-07`; the latter production firmware runs ESPHome `2026.10.1`. |
| Live sensor values | Passed | Pascal reported web visual confirmation on `2026-08-16`; the updated ENS160 production web screenshot was supplied on `2026-11-07`. |
| SGP30 alternate | Passed | ESP32-C6, BME280, BH1750, and SGP30 config, compile, OTA, web access, and live values passed on `2026-08-17`. Public alternate recipe compile hash: `0x743ada86`. |
| Documentation approval | Approved — C3/ENS160 | Approved by Pascal on `2026-11-07` after final review, production OTA/log checks and both visual checks. C6/SGP30 approval is separate. |

## Package Stack Under Test

The frozen C3/ENS160 release pins its shared packages to public commit
`79c989b279b55249b76417bd184105343a8d5798`. That exact commit was found
in the production device configuration's local package cache during the final
review on `2026-11-07`. The separate C6/SGP30 alternate is not frozen by this
release.

This project validates the Basic stack plus ENS160:

- `boards/esp32/c3_super_mini.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bh1750.yaml`
- `sensors/i2c/aht2x_3x.yaml`
- `sensors/i2c/ens160.yaml`

The verified SGP30 alternate validates:

- `boards/esp32/c6_super_mini.yaml`
- `common/core/settings.yaml`
- `common/time/home_assistant.yaml`
- `common/network/wifi.yaml`
- `common/network/wifi_dynamicip.yaml`
- `common/network/webserver.yaml`
- `sensors/i2c/bh1750.yaml`
- `sensors/i2c/bme280.yaml`
- `sensors/i2c/sgp30.yaml`

## Automated Validation

Final frozen C3 recipe check on `2026-11-07`:

- ESPHome validator: `2026.10.0` from the existing project environment.
- Result: configuration valid, using an isolated fixture with disposable dummy
  secret values and the exact released YAML.
- Known warning: GPIO9 is a strapping pin.
- Dependencies: public commit `79c989b279b55249b76417bd184105343a8d5798`,
  verified against the production configuration's package cache.
- No new test compile was performed during this documentation release. The
  production compile/OTA/live-value evidence below remains the hardware proof.

Historical checks:

Local recipe file:

```text
recipes/projects/room_sense/plus/esphome_room_sense_plus_project.yaml
recipes/projects/room_sense/plus/esphome_room_sense_plus_project_alternate.yaml
```

Validated with:

```text
ESPHome 2026.7.3
```

Results:

- Config validation passed.
- Compile validation passed.
- Local validation-device compile passed, reported by Pascal on `2026-08-16`.
- ENS160 text-sensor fixes config and compile validated on ESPHome `2026.7.3`
  on `2026-08-16`; Pascal reported OTA upload and web visual confirmation
  passed.
- SGP30 alternate config and compile passed on ESPHome `2026.7.3` on
  `2026-08-17`.
- SGP30 alternate public recipe compile used `33.3%` RAM and `65.3%` flash.
- Known board note: GPIO9 is a strapping pin on the ESP32-C3 Super Mini.
- SGP30 alternate known board note: GPIO8 is a strapping pin on the ESP32-C6
  Super Mini.

## Physical Validation

Physical test device:

```text
Private Room Sense Plus validation deployment
```

Reported result:

- Compile passed.
- OTA upload passed.
- Web visual confirmation passed.
- Initial waiting-for-data state should use the standard `Waiting For Data`
  label rather than a blank value.
- ESPHome web-server screenshot captured on `2026-11-07`; see the updated
  production check below.
- Home Assistant device screenshot captured on `2026-11-07`; see the updated
  production check below.

SGP30 alternate reported result:

- Config passed.
- Compile passed.
- OTA upload passed.
- ESPHome web access worked as expected.
- SGP30 eCO2 and TVOC values behaved as expected.

## Production ENS160 Update — 2026-11-07

Pascal reported a successful OTA update of the existing ENS160 production
device. The attached startup log shows ESPHome `2026.10.1`, compiled on
`2026-11-07` at `17:32:19` (Africa/Johannesburg).

- OTA update: passed, reported by Pascal.
- Startup log: reviewed; the ENS160 reports `Setup successful`, firmware
  `5.4.6`, I2C address `0x53`, and a `30s` update interval.
- ENS160 compensation: the log reports `Not configured`.
- Initial startup-log capture: approximately `17:33:04` to `17:33:05`, with
  no ENS160 sample values yet. The later web screenshot below confirms values.
- One API operation took `79ms`, above the logged `50ms` warning threshold;
  this capture does not establish whether that warning recurs.
- ESPHome web-server and Home Assistant device-page screenshots: supplied
  on `2026-11-07` and saved below.

This records the production device update, not a fresh hardware check of the
separate C3 and C6 Desktop test configurations.

### ESPHome Web-Server Check

Pascal supplied the [web-server screenshot](../assets/device-web-server.png)
on `2026-11-07`. It identifies the board as ESP32-C3 Super Mini and shows
ESPHome `2026.10.1`, with populated AHT20, BH1750 and ENS160 entities.

| Reading | Displayed value |
| --- | --- |
| AHT20 temperature | 30.35 °C |
| AHT20 humidity | 40.28% |
| BH1750 illuminance | 0.6 lx |
| ENS160 eCO2 | 1654.0 ppm |
| ENS160 TVOC | 4706.0 ppb |
| ENS160 AQI | 5 |

The screenshot displays the ENS160 classification labels `Bad`, `High` and
`Unhealthy`. These are recorded sensor outputs, not a calibration assessment.
The device title, IP address, Wi-Fi name and configuration hash are masked;
all other screenshot pixels are unchanged. The private original is retained
with the validation evidence.

### Home Assistant Device-Page Check

Pascal supplied the [Home Assistant device-page screenshot](../assets/home-assistant-device.png)
on `2026-11-07`. It shows firmware project version `2026.0.0` running on
ESPHome `2026.10.1`, with populated AHT20, BH1750 and ENS160 entities.

| Reading | Displayed value |
| --- | --- |
| AHT20 temperature | 30.35 °C |
| AHT20 humidity | 39.84% |
| BH1750 illuminance | 0.5 lx |
| ENS160 eCO2 | 1614.0 ppm |
| ENS160 TVOC | 4422.0 ppb |
| ENS160 AQI | 5 |

The classification labels are populated, and the activity panel records
ENS160 air-quality and Wi-Fi signal changes. This confirms the displayed
entities and values reached Home Assistant. It does not establish calibration
accuracy or validate the separate SGP30/C6 build.

The private area label, linked device name, MAC address, Wi-Fi name and IP
address are masked. All other pixels remain unchanged; the private original
is retained with the validation evidence.
