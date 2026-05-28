# I2C Sensor Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Sensor | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| AHT20/AHT30 temperature and humidity sensor | `sensors/i2c/aht2x_3x.yaml` | I2C | Not tested | AHT2x/AHT3x environmental package. |
| AS3935 lightning sensor | `sensors/i2c/as3935.yaml` | I2C | Not tested | Header currently marks the package untested. |
| BH1750 illuminance sensor | `sensors/i2c/bh1750.yaml` | I2C | Not tested | Light level package. |
| BME280 temperature, pressure, and humidity sensor | `sensors/i2c/bme280.yaml` | I2C | Not tested | Environmental package. |
| BME680 temperature, pressure, humidity, and gas sensor | `sensors/i2c/bme680.yaml` | I2C | Not tested | Header currently marks the package untested. |
| CCS811 eCO2 and TVOC air quality sensor | `sensors/i2c/ccs811.yaml` | I2C | Not tested | Air quality package. |
| ENS160 VOC and eCO2 air quality sensor | `sensors/i2c/ens160.yaml` | I2C | Not tested | Air quality package with human-readable text sensors. |
| INA219 DC current sensor | `sensors/i2c/ina219.yaml` | I2C | Not tested | Header currently marks the package untested. |
| LTR390 UV and ambient light sensor | `sensors/i2c/ltr390.yaml` | I2C | Not tested | Light/UV package. |
| Matrix keypad 3x4 | `sensors/i2c/matrix_keypad_3x4.yaml` | GPIO matrix | Not tested | Stored under I2C today; may need folder review later. |
| MPU6050 accelerometer/gyroscope | `sensors/i2c/mpu6050.yaml` | I2C | Not tested | Motion package with additional template logic. |
| SGP30 eCO2 and TVOC air quality sensor | `sensors/i2c/sgp30.yaml` | I2C | Not tested | Air quality package. |
| SGP40 VOC sensor | `sensors/i2c/sgp40.yaml` | I2C | Not tested | VOC package. |
| SHT40 temperature and humidity sensor | `sensors/i2c/sht40.yaml` | I2C | Not tested | Environmental package. |
| SPS30 particulate matter sensor | `sensors/i2c/sps30.yaml` | I2C | Not tested | Particulate matter package. |
| VL53L0X time-of-flight distance sensor | `sensors/i2c/vl53l0.yaml` | I2C | Not tested | Distance sensor package; reference URL needs review. |
