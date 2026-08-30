# HAZA Hydro Sense Basic

> [!WARNING]
> **Disclaimer:** This project is in staged bring-up. The first DS18B20 stage
> has passed compile, serial upload, serial log, and ESPHome web UI checks.
> The contactless liquid level sensor has passed bench validation. RCWL-1670
> level sensing has passed compile and serial upload, but the first shared-pin
> hardware test timed out instead of producing a distance reading. Home
> Assistant pump automation is still pending.

`HAZA Hydro Sense Basic` is the first water-monitoring project in the Hydro
Sense line. The goal is simple: keep an eye on bucket water level and water
temperature, then expose the right signals to Home Assistant so automations can
react.

<details>

<summary><b>Current Status</b></summary><br>

- YAML recipe: `esphome_hydro_sense_basic_project.yaml`
- Current stage: RCWL-1670 added for staged validation
- Hardware scope: ESP32-C6 Super Mini, framework core/network packages, and
  DS18B20 reservoir temperature probe, contactless critical liquid level sensor,
  and RCWL-1670 ultrasonic ranging module
- Automation boundary: Home Assistant reacts to the sensor values
- Config validation: ESPHome 2026.8.1 passed for the RCWL-1670 staged YAML on
  2026-08-25
- Compile validation: Passed for DS18B20, contactless liquid level, and
  RCWL-1670 staged configs
- Physical validation: DS18B20, contactless liquid level, and RCWL-1670 serial
  upload passed
- Live validation: DS18B20 and contactless liquid level stages passed; pending
  for RCWL-1670 distance and fill values
- Documentation approval: Not applicable yet

</details>

## Project Profile

| Factor | Rating | Notes |
| --- | --- | --- |
| Difficulty | Intermediate | Combines 1-Wire, a level-shifted digital input, ultrasonic sensing, and container calibration. |
| Estimated cost | Medium | The waterproof probes and safe interface hardware add to the basic controller cost. |
| Build time | Half a day | Allow extra bench time for voltage checks, mounting, and staged validation. |
| Tools needed | Soldering and a multimeter | A USB data cable, breadboard, jumper wires, and level-shifting parts are also useful. |
| Off-the-shelf viability | Better to build | The value is the custom container calibration and Home Assistant reaction boundary. |
| Maintenance burden | Medium | Sensor mounting, water exposure, calibration points, and probe cleanliness need checking. |

> [!TIP]
> See [Recommended Starter Hardware](https://github.com/homeautomatorza/ESPHome-Modules/wiki/recommended-starter-hardware)
> and [Recommended Starter Tools](https://github.com/homeautomatorza/ESPHome-Modules/wiki/recommended-starter-tools).

## Why Build This?

This is a good Basic set because each part has a clear job:

- The contactless liquid sensor gives Home Assistant the critical “water is too
  low” signal.
- The ultrasonic module gives Home Assistant a percentage-style level reading
  for dashboards and low-level alerts.
- The DS18B20 gives Home Assistant a water temperature reading it can use for
  alerts, dashboards, or later automations.
- The ESP32-C6 Super Mini keeps the controller small and current.

## What Problems It Solves

- Reports reservoir temperature to Home Assistant.
- Provides a separate critical low-water signal for pump-protection logic.
- Aims to provide a calibrated usable-fill estimate without putting electronics in the water.
- Keeps sensing on the ESPHome node while Home Assistant owns the pump reaction.

## What Possibilities It Creates

- Low-water alerts before the reservoir reaches the critical point.
- Home Assistant pump shutdown based on a separately validated safety signal.
- Container-specific level dashboards and temperature history.
- A staged path toward later Hydro Sense monitoring and control projects.

## Home Assistant Reaction Boundary

Hydro Sense Basic does not directly control the pump in Pascal's environment.
It reports sensor state to Home Assistant.

Home Assistant owns the reaction logic:

- if the contactless liquid sensor reports the critical low-water state, a Home
  Assistant automation should turn off the existing pump control
- if the RCWL-1670 fill percentage falls below a chosen warning level, Home
  Assistant can send an alert before the critical shutdown point
- if the DS18B20 water temperature crosses a chosen threshold, Home Assistant
  can alert or trigger another automation
- the ESPHome node should keep the sensor readings clear and reliable, but the
  actions live in Home Assistant

That keeps this Basic device focused. It provides the information needed to
protect the pump and monitor the bucket, while Home Assistant handles the
automation because that is where the pump and reactions are already controlled.

## Water Level Calibration

Hydro Sense Basic uses container-specific distance points for the RCWL-1670
reading. These are exposed as ESPHome `number` entities so they can be adjusted
from Home Assistant and from the ESPHome web UI.

| Entity / variable | Default | Meaning |
| --- | --- | --- |
| `hydro_sense_distance_full_mm` | `40` | Distance from sensor to water when the bucket is treated as full. |
| `hydro_sense_distance_refill_mm` | `150` | Distance where Home Assistant should start asking for a refill. |
| `hydro_sense_distance_critical_mm` | `170` | Minimum safe pump level. This is the 0% point for the usable fill range. |
| `hydro_sense_distance_empty_mm` | `260` | Physical or practical empty distance for the container. |

The substitutions in the YAML provide the first-boot defaults. The frontend
number entities use `restore_value: true`, so changes made from Home Assistant
or the ESPHome web UI should survive a device restart.

For the reported fill percentage, calculate the usable range between
`Distance Full` and `Distance Critical`, not between full and empty.

That makes the percentage pump-safe:

- `Distance Full` = 100%
- `Distance Critical` = 0%
- anything closer than `Distance Full` clamps to 100%
- anything farther than `Distance Critical` clamps to 0%

The basic formula is:

```text
fill_percent = (critical_mm - current_mm) / (critical_mm - full_mm) * 100
```

When YAML logic is added, it should read the live values from the number entity
states, for example `id(hydro_sense_distance_full_mm).state`, rather than using
the substitution defaults directly.

With the current defaults, `Distance Refill` at 150 mm is roughly 15% of the
usable pump-safe range. `Distance Empty` is still useful for diagnostics and
container understanding, but it should not be the 0% point if the pump must stop
at the critical level.

## DS18B20 Stage Evidence

- The DS18B20 address was confirmed during private hardware validation and is
  intentionally left as a placeholder in the public recipe.
- GPIO0 works for the DS18B20 1-Wire bus in this build.
- Serial push completed successfully.
- Serial logs showed the DS18B20 address and live temperature readings.
- ESPHome web UI showed the DS18B20 Celsius and Fahrenheit entities.
- ESPHome web UI showed the Hydro Sense calibration numbers as adjustable
  controls.
- Home Assistant API connected during the log check.

The next hardware stage should add one sensor only, then repeat the same
compile, upload, log, and web checks before adding anything else.

## Contactless Liquid Level Stage

The contactless liquid level sensor is added on `GPIO1` as a digital binary
sensor for the next hardware pass.

DFRobot lists the SEN0204 operating voltage as `5-24 V`, with the output high
level equal to the input supply voltage. If the sensor is powered from `5 V`,
the output may also be `5 V`.

Do not connect the signal wire directly to the ESP32-C6 until the output has
been measured or safely level-shifted to `3.3 V`.

For this stage, the observed polarity is:

- `true` = liquid detected
- `false` = no liquid detected

Early bouncing during bench testing was traced back to a contact problem rather
than the sensor itself. The current filter is kept light: it lets `true`
register quickly and gives `false` a short settling delay.

## RCWL-1670 Stage

The RCWL-1670 is added as the next staged sensor on shared `GPIO2` using
ESPHome's `ultrasonic` platform.

This board variant exposes a shared trigger/echo signal, so the config uses the
same GPIO for both `trigger_pin` and `echo_pin` with `allow_other_uses: true`.

The module is powered from `3.3 V` for this stage, avoiding the need for a
bidirectional level shifter on the shared signal line.

The first shared-pin hardware test did not produce a distance reading. ESPHome
reported repeated `Measurement start timed out` warnings, which means the echo
pulse never started from ESPHome's point of view. Treat `Water Distance` and
`Water Fill` as unvalidated until that timeout is resolved.

After 5 V power through a bidirectional level shifter did not resolve the
timeout, a longer `50us` trigger pulse was tested. That also failed to produce
a live reading. The next useful check is whether this board exposes separate
RX/TX pads or an alternate UART mode, because shared-pin ESPHome `ultrasonic`
mode has not worked in this build.

The staged outputs are:

- `Water Distance`: raw ultrasonic distance in millimetres
- `Water Fill`: calculated usable fill percentage

`Water Fill` uses the pump-safe range:

- `Distance Full` = 100%
- `Distance Critical` = 0%

It clamps the result between 0% and 100%. If the ultrasonic reading is unknown,
or if the calibration values are invalid, the percentage reports unknown.

## Still Needed For Later Stages

- Resolve RCWL-1670 `Measurement start timed out` on shared `GPIO2`.
- Check whether this RCWL-1670 board exposes separate RX/TX pads or a UART mode.
- Confirm whether the RCWL-1670 behaves reliably at `3.3 V` or needs a
  different mode/wiring approach.
- Confirm RCWL-1670 mounting position and usable distance range.
- Confirm final bucket calibration points for full, refill, critical, and empty
  distances.
- Existing Home Assistant pump-control entity and the automation rule that
  should turn it off.
- Warning and critical thresholds for bucket percentage, low-water state, and
  water temperature.
- Validation target for the RCWL-1670 hardware stage.

## Hardware And Bill Of Materials

| Role | Part | Purpose | Notes |
| --- | --- | --- | --- |
| MCU | ESP32-C6 Super Mini | Runs the Hydro Sense Basic node | Small, modern ESP32 board with enough GPIO for this first version. |
| Critical low-water detection | DFRobot SEN0204 / XKC-Y25-T12V contactless liquid sensor | Exposes the critical low-water signal to Home Assistant | Home Assistant will use this signal to turn off the existing pump control. The sensor needs 5-24 V power and its high output follows the input supply voltage, so the GPIO signal must be measured or level-shifted before connecting it to the ESP32-C6. |
| Water level estimate | RCWL-1670 waterproof ultrasonic ranging module | Estimates bucket percentage fill | Good fit for a non-contact level reading. Home Assistant can use this for low-level alerts. Needs calibration against the actual bucket height and usable water range. |
| Water temperature | DS18B20 digital temperature sensor | Reports bucket water temperature to Home Assistant | Home Assistant can react to this temperature later. Needs a pull-up resistor and a waterproof probe style suitable for the bucket. |

> [!WARNING]
> Alternatives are not automatically drop-in replacements. Check supply and
> signal voltage, level shifting, GPIO mapping, waterproofing, mounting,
> package changes, and calibration. The RCWL-1670 distance stage in this build
> is not yet producing a live reading.

## Who This Is For

Build this if you need a repairable reservoir monitor and are comfortable
testing one sensor at a time around water. Use it as a reference rather than a
finished protection system until your own low-water signal and Home Assistant
pump action have been tested end to end.

## Wiring

```text
[Image placeholder: assets/fritzing.png]
```

| Component | Pin | Connects To ESP32 | Notes |
| --- | --- | --- | --- |
| DS18B20 | DATA | GPIO0 | Use the required 1-Wire pull-up resistor. |
| Contactless level sensor | OUT | GPIO1 through a safe interface | Its high output follows its supply voltage; measure it or level-shift it to 3.3 V. |
| RCWL-1670 | Shared signal | GPIO2 | Current staged test uses shared trigger/echo at 3.3 V. |
| All sensors | GND | GND | Use a common ground where the interface design requires it. |

> [!WARNING]
> Disconnect power before changing wiring. Keep mains-powered pump wiring out
> of this low-voltage sensor build. ESP32 GPIO uses 3.3 V logic; follow
> [Using A Level Shifter](https://github.com/homeautomatorza/ESPHome-Modules/wiki/using-a-level-shifter)
> where the attached sensor requires one.

## Setup

1. Copy or import the [recipe YAML](esphome_hydro_sense_basic_project.yaml).
2. Set the device substitutions, DS18B20 address, pins, and initial container distances.
3. Confirm the required secret names exist in your own `secrets.yaml`.
4. Wire and validate one sensor stage at a time.
5. Validate the configuration, then compile the firmware.
6. For a new or repurposed board, follow [First Firmware Upload](https://github.com/homeautomatorza/ESPHome-Modules/wiki/first-firmware-upload).
7. Check logs and the web server; do not treat an unknown RCWL value as a valid level.
8. Add or review the device in Home Assistant, then test any pump reaction separately.

<details>

<summary><b>Framework Packages Used</b></summary><br>

- Board: `boards/esp32/c6_super_mini.yaml`
- Core: `common/core/settings.yaml`
- Time: `common/time/home_assistant.yaml`
- Network helpers: `common/network/wifi.yaml`
- Public recipe network: `common/network/wifi_dynamicip.yaml`
- Web server: `common/network/webserver.yaml`
- Sensor: `sensors/one_wire/ds18b20.yaml`
- Binary sensor: `sensors/binary/xkc_y25_t12v.yaml`
- Project-local sensor logic: RCWL-1670 distance and usable-fill calculation

</details>

## Visual Checks

Still to add:

```text
[Image placeholder: ESPHome web server with the validated DS18B20 and contactless level entities]
[Image placeholder: Home Assistant device page]
[Image placeholder: final sensor mounting and Fritzing diagram]
```

## Home Assistant Entities

<details>

<summary><b>Expected user-facing entities</b></summary><br>

- DS18B20 reservoir temperature
- Contactless liquid detected state
- Water Distance, currently unvalidated because the RCWL-1670 times out
- Water Fill, currently unvalidated because it depends on Water Distance
- Distance Full, Refill, Critical, and Empty configuration numbers
- Standard uptime, network, status, and diagnostic entities

The exact entity IDs depend on the device substitutions used for the local
deployment.

</details>

## Calibration And Tuning

Set the full, refill, critical, and empty distances against the actual
container. The detailed pump-safe calculation and current defaults are recorded
in [Water Level Calibration](#water-level-calibration). Do not calibrate around
the RCWL-1670 until it produces stable live distance readings.

## Validation Evidence



## Troubleshooting



## Changelog

See [changelog.md](documents/changelog.md).

## Files In This Project

- `esphome_hydro_sense_basic_project.yaml`: current staged project YAML.
- `documents/validation.md`: staged validation evidence.
- `documents/troubleshooting.md`: troubleshooting notes.
- `documents/changelog.md`: project change history.

## Related Projects And Next Variants

- Later Hydro Sense variants can add control only after the sensing and Home Assistant reaction boundary are proven.
- The unresolved RCWL-1670 interface remains the next hardware investigation for this Basic build.
