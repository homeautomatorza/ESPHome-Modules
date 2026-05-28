# UART Sensor Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Sensor / Module | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| AJ-SR04M waterproof ultrasonic range finder | `sensors/uart/aj_sr04m.yaml` | UART | Not tested | Currently under review because AJ-SR04M behaviour depends on module mode and wiring. |
| GPS receiver | `sensors/uart/gps.yaml` | UART | Not tested | Header title currently appears mismatched and needs cleanup. |
| HLK-LD2410C mmWave presence sensor | `sensors/uart/hlk_ld2410c_minimal.yaml` | UART | Not tested | Minimal LD2410C package. |
