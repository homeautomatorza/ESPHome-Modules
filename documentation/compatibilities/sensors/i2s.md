# I2S Sensor Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Sensor / Audio Package | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| I2S audio output mono | `sensors/i2s/audio_out_mono.yaml` | I2S | Not tested | Imported with placeholder version; may belong under peripherals/audio later. |
| I2S audio output stereo | `sensors/i2s/audio_out_stereo.yaml` | I2S | Not tested | Imported with placeholder version; may belong under peripherals/audio later. |
| INMP441 microphone | `sensors/i2s/inmp441_mic.yaml` | I2S | Not tested | Digital microphone package. |
