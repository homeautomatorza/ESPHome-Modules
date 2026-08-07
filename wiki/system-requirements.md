# System Requirements

This page is a placeholder while the full system requirements guide is being
rebuilt.

## Minimum

To use the HAZA ESPHome Modular Framework, you need:

- ESPHome installed and working
- a compatible ESP32 or ESP8266 board
- a way to edit YAML files
- a USB cable or other supported flashing method for your board
- the required secrets and substitutions for the modules you choose to use

Visual Studio Code is recommended, especially with ESPHome or YAML extensions,
but it is not the only editor that can be used.

## Recommended

For a smoother workflow, use:

- Git, if you want to clone the repository or keep it updated locally
- Visual Studio Code or another YAML-aware editor
- Home Assistant, if your device uses Home Assistant API features, time, or
  entities
- access to the ESPHome logs for troubleshooting

## Notes

Some modules have their own hardware, wiring, secrets, substitutions, or
calibration requirements. Those details belong in the module or project
documentation once each page is rebuilt.

Automated ESPHome checks can confirm that YAML parses and firmware compiles, but
real hardware behavior still needs physical testing.
