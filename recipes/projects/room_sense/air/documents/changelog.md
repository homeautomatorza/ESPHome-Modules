# Changelog

- 2026-08-17: Stage 1 hardware validation passed after replacing a suspect
  ESP32-C6 board. ESPHome web server showed live BH1750 and BME280 values.
  Local bring-up overrides were then removed; OTA and authenticated web access
  still worked.
- 2026-08-17: Added SPS30 as Stage 3. Compile, OTA, log, and web checks passed
  on private hardware. ESPHome web server showed live particulate readings.
- 2026-08-17: Added SGP30 as Stage 2 with BME280 temperature and humidity
  compensation. Config and compile passed; Pascal reported the stage working as
  expected on private hardware.
- 2026.0.0: Created the staged Room Sense Air project with ESP32-C6, BH1750,
  and BME280.
