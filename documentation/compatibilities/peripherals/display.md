# Display Peripheral Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Display | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| DFRobot GDI 0.96 inch IPS LCD 160x80 | `peripherals/display/dfrobot_096_160x80_spi_gdi.yaml` | SPI | Not tested | ST7735 display with LEDC backlight package. |
| DFRobot GDI 2.0 inch IPS LCD 320x240 touch display | `peripherals/display/dfrobot_20_320x240_spi_gdi.yaml` | SPI | Not tested | ILI9xxx display with touch/microSD hardware family. |
| DFRobot GDI 2.8 inch IPS LCD 320x240 touch display | `peripherals/display/dfrobot_28_320x240_spi_gdi.yaml` | SPI | Not tested | ILI9xxx display with touch/microSD hardware family. |
| DFRobot GDI 3.5 inch IPS LCD 480x320 touch display | `peripherals/display/dfrobot_35_480x320_spi_gdi.yaml` | SPI | Not tested | ILI9xxx display with touch/microSD hardware family. |
| Generic 0.42 inch 72x40 SSD1306 OLED | `peripherals/display/ssd1306_0_42_oled_i2c.yaml` | I2C | Not tested | Small SSD1306 display package. |
