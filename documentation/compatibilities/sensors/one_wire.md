# One Wire Sensor Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Sensor | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| DS18B20 temperature sensor | `sensors/one_wire/ds18b20.yaml` | One Wire | Not tested | Dallas/Maxim temperature sensor package. |
