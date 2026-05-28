# Compatibility

This folder contains public compatibility references for supported boards,
peripherals, and sensor packages.

Compatibility pages are split to match the repository layout. This keeps the
lists easy to scan and makes it clear where each package lives.

## Current Documents

- [Boards](boards.md)
- [Peripherals](peripherals/README.md)
- [Sensors](sensors/README.md)

## Status Legend

Use these status values for new compatibility charts. The board list still
preserves some historical fields and should be converted during a dedicated
board compatibility pass.

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

AI-assisted validation is part of this project workflow. It helps catch syntax,
include, and ESPHome configuration issues early, but it does not replace human
hardware testing.
