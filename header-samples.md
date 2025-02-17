# Sample File Headings

## ESPHome Device File Heading

    ################################################################################
    # ESPHome Device File
    ################################################################################
    # The components used are:
    #     - DFRobot Firebeetle 2 ESP 32 S3 N16R8 Board
    #         - Enabled hardware and services:
    #             - WiFi
    #             - Bluetooth Proxy
    #             - Bluetooth Tracker (Beta)
    #             - Webserver
    #     - HC-SR501 Passive Infrared Sensor
    #     - HLK-LD2410C mmWave Presence Detection Sensor
    #     - SHT40 Temperature and humidity sensor
    #     - BH1750 Illuminence Sensor
    #     - SPG30 eCO2 and TVOC Air Quality Sensor
    #     - 2.8" TFT SPI 320x240 Touch Screen (ILI9341 / XPT2046)
    # ------------------------------------------------------------------------------
    # Author: Pascal Parent
    # Company: Home Automator (ZA)
    # Web: https://www.youtube.com/@homeautomatorza
    # Version: 1.0.0
    # Licence: CCO 1.0 https://creativecommons.org/publicdomain/zero/1.0/
    # ------------------------------------------------------------------------------
    # Notes: 
    #       - None
    # ------------------------------------------------------------------------------
    # WARNING:
    # This code carries a "It works on my setup" disclaimer!
    # Meaning that it works on my setup but it may not work on yours.
    # Use at your own risks!
    ################################################################################

## Sample Board File Heading

    ################################################################################
    # Espressif ESP32-C3-MINI-1
    ################################################################################
    # Usage:
    #   Add the following code to package section in the device file
    # ------------------------------------------------------------------------------
    # packages:
    #   board: !include boards/esp32/c3_mini_espressif
    # ------------------------------------------------------------------------------
    # Author: Pascal Parent
    # Company: Home Automator (ZA)
    # Web: https://www.youtube.com/@homeautomatorza
    # Version: 1.0.0
    # Licence: CCO 1.0 https://creativecommons.org/publicdomain/zero/1.0/
    # ------------------------------------------------------------------------------
    # Notes:
    #     - Tested OK
    # ------------------------------------------------------------------------------
    # Referance: https://docs.espressif.com/projects/arduino-esp32/en/latest/boards/ESP32-C3-DevKitM-1.html
    # Spec: 
    #     - ESP32-C3FN4 RISCV Single Core 
    #     - 2.4 GHz Wi­Fi (802.11 b/g/n) and Bluetooth 5 module
    #     - 4 MB flash
    #     - 1 × I2C
    #     - 1 × I2S
    #     - 3 x SPI
    #     - 2 x UART
    #     - 2 × 12-bit SAR ADC
    #     - 1 x RGB LED
    #     - 1 x Internal Temperature Sensor
    # ------------------------------------------------------------------------------
    # WARNING:
    # This code carries a "It works on my setup" disclaimer!
    # Meaning that it works on my setup but it may not work on yours.
    # Use at your own risks!
    ################################################################################

## Sample Common File Heading

    ################################################################################
    # Common Settings
    ################################################################################
    # Usage:
    #   Add the following code to package section in the device file
    # ------------------------------------------------------------------------------
    # packages:
    #   board: !include common/settings.yaml
    # ------------------------------------------------------------------------------
    # Author: Pascal Parent
    # Company: Home Automator (ZA)
    # Web: https://www.youtube.com/@homeautomatorza
    # Version: 1.2.0
    # Licence: CCO 1.0 https://creativecommons.org/publicdomain/zero/1.0/
    # ------------------------------------------------------------------------------
    # Notes:
    #     - Tested OK
    # ------------------------------------------------------------------------------
    # WARNING:
    # This code carries a "It works on my setup" disclaimer!
    # Meaning that it works on my setup but it may not work on yours.
    ################################################################################

## Sample Peripheral or Sensor File

    ################################################################################
    # BH1750 Illuminence Sensor
    ################################################################################
    # Usage:
    #   Add the following code to package section in the device file changing the 
    #   I2C Address.
    # -----------------------------------------------------------------------------
    # packages:
    #  bh1750: !include 
    #    file: sensors/digital/i2c/bh1750.yaml
    #    vars:
    #      i2c_address: 0x23
    # ------------------------------------------------------------------------------
    # Author: Pascal Parent
    # Company: Home Automator (ZA)
    # Web: https://www.youtube.com/@homeautomatorza
    # Version: 1.0.0
    # Licence: CCO 1.0 https://creativecommons.org/publicdomain/zero/1.0/
    # Reference: https://esphome.io/components/sensor/bh1750.html
    # ------------------------------------------------------------------------------
    # Notes:
    #     - Tested OK
    # ------------------------------------------------------------------------------
    # WARNING:
    # This code carries a "It works on my setup" disclaimer!
    # Meaning that it works on my setup but it may not work on yours.
    ################################################################################