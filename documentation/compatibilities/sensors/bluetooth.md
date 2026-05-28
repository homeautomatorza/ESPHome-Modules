# Bluetooth Sensor Compatibility

## Status Legend

| Status | Meaning |
| --- | --- |
| Not tested | No ESPHome compilation has been done in this rebuild. |
| Needs validation | AI-assisted review and ESPHome compilation/config validation found no blocking errors, but the package has not been validated on physical hardware by a person. |
| Experimental | In active development. It is expected to compile and might work, but behaviour is still being proven. |
| Tested | Validated on physical hardware. The ESPHome version used for validation must be recorded in the notes or a dedicated version column. |

| Sensor / Package | Package | Interface | Status | Notes |
| --- | --- | --- | --- | --- |
| Mi Scale 2 BLE sensor | `sensors/bluetooth/miscale2.yaml` | Bluetooth LE | Not tested | Requires Bluetooth tracker/proxy support on the device. |
| Mopeka Pro Check BLE sensor | `sensors/bluetooth/mopeka_pro_check.yaml` | Bluetooth LE | Not tested | Header notes Bluetooth proxy and BLE tracker requirements. |
| Room presence BLE tracker | `sensors/bluetooth/tracker.yaml` | Bluetooth LE | Not tested | Imported with placeholder version and external reference. |
