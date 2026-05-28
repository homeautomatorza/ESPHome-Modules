# Sensor Compatibility

Sensor compatibility is split by package type to match the `sensors/` folder.

## Documents

- [Analogue](analogue.md)
- [Binary](binary.md)
- [Bluetooth](bluetooth.md)
- [I2C](i2c.md)
- [I2S](i2s.md)
- [One Wire](one_wire.md)
- [UART](uart.md)

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

## Notes

- `Not tested` means no ESPHome compilation has been run in this rebuild.
- `Needs validation` means AI-assisted review and ESPHome compilation/config
  validation found no blocking errors, but physical hardware behaviour is not
  yet confirmed by a person.
- `Experimental` means the package is still in active development or depends on
  beta/development ESPHome functionality.
- `Tested` requires physical validation and the ESPHome version used for that
  validation.
- Keep package names aligned with the actual file paths.
