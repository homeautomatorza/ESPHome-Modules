# Analogue Sensor Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Sensor | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| CT Clamp current sensor | `sensors/analogue/ct_clamp.yaml` | ADC | Not tested | Analogue current monitoring package. |
| MiCS-5524 gas sensor | `sensors/analogue/mics_5524.yaml` | ADC | Not tested | Header references community calibration guidance. |
| pH sensor | `sensors/analogue/ph_sensor.yaml` | ADC | Not tested | Analogue pH package. |
| SparkFun anemometer | `sensors/analogue/sparkfun_anemometer.yaml` | ADC | Not tested | Weather station wind speed package. |
| SparkFun rain gauge | `sensors/analogue/sparkfun_rain_gauge.yaml` | GPIO pulse/counter | Not tested | Weather station rainfall package. |
| SparkFun wind vane | `sensors/analogue/sparkfun_wind_vane.yaml` | ADC | Not tested | Weather station wind direction package. |
| TDS sensor | `sensors/analogue/tds_sensor.yaml` | ADC | Not tested | Analogue total dissolved solids package. |
| YF-B10 water flow sensor | `sensors/analogue/yf_b10.yaml` | GPIO pulse/counter | Not tested | Imported with placeholder version; needs cleanup and validation. |
