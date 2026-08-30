# HAZA Hydro Sense Basic Validation

This file records staged validation evidence for Hydro Sense Basic.

## Current Status

- Project YAML: `esphome_hydro_sense_basic_project.yaml`
- Current stage: RCWL-1670 shared-pin ultrasonic test failed to produce a live
  distance reading
- Config validation: Passed with ESPHome 2026.8.1 on 2026-08-25 for the
  RCWL-1670 staged YAML
- Compile validation: Passed for DS18B20, contactless liquid level, and
  RCWL-1670 staged configs
- Physical upload: Passed for DS18B20, contactless liquid level, and RCWL-1670
  staged configs
- Live values: Passed for DS18B20 and contactless liquid level stages; pending
  for RCWL-1670 distance and fill values
- Documentation approval: Not applicable yet

## Current Stage

This stage includes:

- ESP32-C6 Super Mini board package
- common settings, time, WiFi, dynamic IP, and web server packages
- DS18B20 waterproof reservoir temperature probe package
- DFRobot SEN0204 / XKC-Y25-T12V contactless liquid level sensor package on
  GPIO1
- RCWL-1670 ultrasonic distance reading on shared GPIO2
- pump-safe water fill percentage calculation
- frontend-adjustable Hydro Sense calibration number entities

No pump-control automation has been added yet.

## DS18B20 Hardware Evidence

- Serial push completed successfully.
- Serial log check completed successfully.
- ESPHome web UI check completed successfully.
- The DS18B20 address was confirmed during private hardware validation and is
  intentionally not published in the public recipe.
- GPIO0 detected the DS18B20 on the 1-Wire bus.
- Serial logs reported a live DS18B20 temperature reading.
- ESPHome web UI showed Celsius and Fahrenheit DS18B20 entities with live
  values.
- ESPHome web UI showed the frontend-adjustable Hydro Sense calibration number
  entities.
- Home Assistant API connected during the log check.

## Still Pending

- Resolve RCWL-1670 `Measurement start timed out` before using `Water Distance`
  or `Water Fill` in Home Assistant.
- Investigate whether this RCWL-1670 board exposes separate RX/TX pads or an
  alternate UART mode, because shared-pin ESPHome `ultrasonic` mode has not
  produced a live echo.
- Confirm live `Water Distance` and `Water Fill` values behave correctly after
  the RCWL timeout is resolved.
- Create and validate the Home Assistant pump-protection automation against
  Pascal's existing pump control.

## Evidence Log

| Date | Check | Result | Notes |
| --- | --- | --- | --- |
| 2026-08-25 | ESPHome config | Passed | `.venv/bin/esphome config recipes/projects/hydro_sense/basic/esphome_hydro_sense_basic_project.yaml` passed on ESPHome 2026.8.1. |
| 2026-08-25 | ESPHome compile | Inconclusive | Compile was started but stayed silent for several minutes after C++ generation and was interrupted. Do not claim compile validation from this run. |
| 2026-08-25 | ESPHome compile | Passed | Pascal reported the serial-build compile pass for the DS18B20 stage. |
| 2026-08-25 | Serial push | Passed | Pascal reported a successful serial push to the ESP32-C6 Super Mini. |
| 2026-08-25 | Serial log | Passed | Log evidence showed GPIO0 1-Wire detection, a confirmed DS18B20 address, and a live DS18B20 temperature reading. The unique address is intentionally not published. |
| 2026-08-25 | ESPHome web UI | Passed | Screenshot evidence showed live DS18B20 Celsius/Fahrenheit readings, online status, diagnostics, and adjustable Hydro Sense calibration numbers. |
| 2026-08-25 | Contactless liquid level sensor added | Passed bench validation | Added DFRobot SEN0204 / XKC-Y25-T12V package on GPIO1 through a level shifter. DFRobot specs say output high level follows input supply voltage, so level shifting remains part of the wiring requirement. |
| 2026-08-25 | Contactless liquid level polarity | Observed | Pascal observed physical LED ON when liquid is detected and OFF without liquid. In ESPHome this maps to `true` = liquid detected and `false` = no liquid detected. |
| 2026-08-25 | Contactless liquid level stability | Passed bench validation | Initial bouncing was traced to a contact problem. The retained light filter is `delayed_on: 50ms` and `delayed_off: 1s`. |
| 2026-08-25 | RCWL-1670 config | Passed preliminary validation | Added ESPHome `ultrasonic` stage with shared trigger/echo on GPIO2 using `allow_other_uses: true`, raw `Water Distance` in mm, and calculated `Water Fill` percentage. Public recipe and private ESPHome config passed ESPHome 2026.8.1 config validation. Compile, OTA, log, web, and live-distance checks are pending. |
| 2026-08-25 | RCWL-1670 serial push | Passed firmware stage, failed live reading | Pascal reported compile and serial push passed. Logs showed `Water Distance` configured with Echo Pin GPIO2 and Trigger Pin GPIO2, but repeated `Measurement start timed out` warnings. Web UI showed `Water Distance` and `Water Fill` as `NA`. Treat this as an RCWL shared-pin/runtime failure, not a validated distance reading. |
| 2026-08-25 | RCWL-1670 pulse tuning | Tested | Increased shared-pin ultrasonic trigger pulse from `10us` to `50us` after 5 V through a bidirectional level shifter did not resolve the timeout. |
| 2026-08-25 | RCWL-1670 50us pulse retest | Failed live reading | Pascal reported no resolution after the `50us` pulse test. Shared-pin ESPHome `ultrasonic` mode still has no validated distance reading. |
| 2026-08-25 | Project scaffold | Scaffold only | No device assumptions made. |
