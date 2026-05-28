# Sample File Headers

These header samples define the current ESPHome Modular Rebuild header standard.

Use only the sections that add value for the file. Omit empty sections.

Preferred section order:

- component or device name
- author, web, version, and licence
- warning
- specifications
- bill of materials
- references
- usage
- package exposes
- notes

## ESPHome Device File Header

```yaml
################################################################################
# ESPHome Device File
################################################################################
# Author: Pascal Parent
# Web: https://www.youtube.com/@homeautomatorza
# Version: 1.0.0
# Licence: CC0 1.0 https://creativecommons.org/publicdomain/zero/1.0/
# ------------------------------------------------------------------------------
# WARNING:
# This code carries an "It works on my setup" disclaimer.
# Meaning that it works on my setup but it may not work on yours.
# Use at your own risk.
# ------------------------------------------------------------------------------
# Bill of Materials:
#     - DFRobot Firebeetle 2 ESP 32 S3 N16R8 Board
#         - Enabled hardware and services:
#             - WiFi
#             - Bluetooth Proxy
#             - Bluetooth Tracker (Beta)
#             - Webserver
#     - HC-SR501 Passive Infrared Sensor
#     - HLK-LD2410C mmWave Presence Detection Sensor
#     - SHT40 Temperature and humidity sensor
#     - BH1750 Illuminance Sensor
#     - SGP30 eCO2 and TVOC Air Quality Sensor
#     - 2.8" TFT SPI 320x240 Touch Screen (ILI9341 / XPT2046)
# ------------------------------------------------------------------------------
# Notes:
#       - None
################################################################################
```

## Board File Header

```yaml
################################################################################
# Espressif ESP32-C3-MINI-1
################################################################################
# Author: Pascal Parent
# Web: https://www.youtube.com/@homeautomatorza
# Version: 1.0.0
# Licence: CC0 1.0 https://creativecommons.org/publicdomain/zero/1.0/
# ------------------------------------------------------------------------------
# WARNING:
# This code carries an "It works on my setup" disclaimer.
# Meaning that it works on my setup but it may not work on yours.
# Use at your own risk.
# ------------------------------------------------------------------------------
# Specifications:
#     - ESP32-C3FN4 RISC-V single core
#     - 2.4 GHz WiFi (802.11 b/g/n) and Bluetooth 5 module
#     - 4 MB flash
#     - 1 x I2C
#     - 1 x I2S
#     - 3 x SPI
#     - 2 x UART
#     - 2 x 12-bit SAR ADC
#     - 1 x RGB LED
#     - 1 x internal temperature sensor
# ------------------------------------------------------------------------------
# References:
#     - https://docs.espressif.com/projects/arduino-esp32/en/latest/boards/ESP32-C3-DevKitM-1.html
#     - https://esphome.io/components/esp32.html
#     - https://esphome.io/components/i2c.html
#     - https://esphome.io/components/uart.html
#     - https://esphome.io/components/spi.html
#     - https://esphome.io/components/sensor/index.html
# ------------------------------------------------------------------------------
# Usage:
#   Add the following code to the package section in the device file.
#
# packages:
#   board: !include boards/esp32/c3_mini_espressif.yaml
# ------------------------------------------------------------------------------
# This package exposes:
#   - ESP32 board/platform configuration
#   - I2C bus configuration
#   - UART bus configuration
#   - SPI bus configuration
#   - sensor entities
# ------------------------------------------------------------------------------
# Notes:
#     - Tested OK
################################################################################
```

## Common File Header

```yaml
################################################################################
# Common Settings
################################################################################
# Author: Pascal Parent
# Web: https://www.youtube.com/@homeautomatorza
# Version: 1.2.0
# Licence: CC0 1.0 https://creativecommons.org/publicdomain/zero/1.0/
# ------------------------------------------------------------------------------
# WARNING:
# This code carries an "It works on my setup" disclaimer.
# Meaning that it works on my setup but it may not work on yours.
# ------------------------------------------------------------------------------
# References:
#     - https://esphome.io/components/esphome.html
#     - https://esphome.io/components/logger.html
#     - https://esphome.io/components/api.html
#     - https://esphome.io/components/ota.html
#     - https://esphome.io/components/safe_mode.html
# ------------------------------------------------------------------------------
# Usage:
#   Add the following code to the package section in the device file.
#
# packages:
#   settings: !include common/core/settings.yaml
# ------------------------------------------------------------------------------
# This package exposes:
#   - ESPHome project-level options
#   - logger configuration
#   - Home Assistant native API service
#   - OTA update configuration
#   - safe mode configuration
# ------------------------------------------------------------------------------
# Notes:
#     - Tested OK
################################################################################
```

## Peripheral Or Sensor File Header

```yaml
################################################################################
# BH1750 Illuminance Sensor
################################################################################
# Author: Pascal Parent
# Web: https://www.youtube.com/@homeautomatorza
# Version: 1.0.0
# Licence: CC0 1.0 https://creativecommons.org/publicdomain/zero/1.0/
# ------------------------------------------------------------------------------
# WARNING:
# This code carries an "It works on my setup" disclaimer.
# Meaning that it works on my setup but it may not work on yours.
# ------------------------------------------------------------------------------
# References:
#     - https://esphome.io/components/sensor/index.html
#     - https://esphome.io/components/sensor/bh1750.html
#     - https://esphome.io/components/text_sensor/index.html
# ------------------------------------------------------------------------------
# Usage:
#   Add the following code to the package section in the device file, changing the
#   I2C address where needed.
#
# packages:
#   bh1750: !include
#     file: sensors/i2c/bh1750.yaml
#     vars:
#       i2c_address: 0x23
# ------------------------------------------------------------------------------
# This package exposes:
#   - sensor entities
#   - text sensor entities
# ------------------------------------------------------------------------------
# Notes:
#     - Tested OK
################################################################################
```
