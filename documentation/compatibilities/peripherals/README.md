# Peripheral Compatibility

Peripheral compatibility is split by package type to match the `peripherals/`
folder.

## Documents

- [Displays](display.md)
- [Speakers](speakers.md)

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

## Notes

- Use `Not tested` until ESPHome compilation has been run.
- Use `Needs validation` after AI-assisted review and ESPHome
  compilation/config validation succeed, but before human hardware testing.
- Use `Experimental` for packages using beta or development ESPHome components,
  even when they compile.
- Use `Tested` only after physical validation, and record the ESPHome version.
