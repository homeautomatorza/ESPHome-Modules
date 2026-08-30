# Changelog

- 2026-08-25: Pascal added core, network, ESP32-C6 Super Mini, and DS18B20
  packages for the first staged sensor bring-up. ESPHome 2026.8.1 config
  validation passes.
- 2026-08-25: DS18B20 stage passed compile, serial push, serial log check, and
  ESPHome web UI check. The unique DS18B20 address was confirmed privately and
  is not published in the recipe.
- 2026-08-25: Added DFRobot SEN0204 / XKC-Y25-T12V contactless liquid level
  sensor on GPIO1 for the next staged validation pass. Voltage-level safety
  must be checked before connecting the signal to the ESP32-C6.
- 2026-08-25: Confirmed contactless liquid level polarity as `true` = liquid
  detected and `false` = no liquid detected. Added debounce filtering after two
  sensors showed bouncing during bench testing. The cause was later traced to a
  contact problem, so the filter was kept light at `delayed_on: 50ms` and
  `delayed_off: 1s`.
- 2026-08-25: Added RCWL-1670 ultrasonic ranging stage using shared
  trigger/echo on GPIO2 at 3.3 V. Preliminary ESPHome 2026.8.1 config
  validation passes for the public recipe and private ESPHome config.
- 2026-08-25: RCWL-1670 compile and serial upload passed, but live ultrasonic
  readings failed with repeated `Measurement start timed out` warnings. Web UI
  showed `Water Distance` and `Water Fill` as `NA`.
- 2026-08-25: Retesting the RCWL-1670 with `pulse_time: 50us` still did not
  resolve the shared-pin timeout.
- 2026-08-25: Added Pascal's proposed Hydro Sense Basic BOM: ESP32-C6 Super
  Mini, contactless liquid sensor, RCWL-1670 waterproof ultrasonic module, and
  DS18B20 water temperature probe.
- 2026-08-25: Clarified that pump shutdown happens through Home Assistant
  automation. Hydro Sense Basic reports sensor state; it does not directly
  switch the pump.
- 2026-08-25: Clarified that water temperature is also a reporting signal for
  Home Assistant to react to, not local ESPHome control logic.
- 2026-08-25: Added customizable RCWL-1670 distance variables for full, refill,
  critical, and empty levels. Fill percentage will be calculated over the
  pump-safe full-to-critical range.
- 2026-08-25: Exposed the RCWL-1670 calibration points as frontend-adjustable
  ESPHome number entities for Home Assistant and the ESPHome web UI.
- 2026-08-25: Created neutral Hydro Sense Basic scaffold. No hardware,
  behavior, or validation assumptions are made.
