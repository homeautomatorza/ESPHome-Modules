# Speaker Peripheral Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Speaker / Audio Package | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| SendSpin PCM5102 speaker | `peripherals/speakers/sendspin_pcm5102.yaml` | I2S | Experimental | Requires ESPHome `2026.6.0-dev` during current validation because it uses SendSpin and `speaker_source`. |
