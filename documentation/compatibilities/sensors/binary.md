# Binary Sensor Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Sensor | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| HC-SR501 PIR motion sensor | `sensors/binary/hc_sr501.yaml` | GPIO | Not tested | Passive infrared motion package. |
| TTP223 capacitive touch sensor | `sensors/binary/ttp223.yaml` | GPIO | Not tested | Includes touch-state binary sensor and template switch behaviour. |
| XKC-Y25-T12V non-contact water level sensor | `sensors/binary/xkc_y25_t12v.yaml` | GPIO | Not tested | Digital water level package. |
