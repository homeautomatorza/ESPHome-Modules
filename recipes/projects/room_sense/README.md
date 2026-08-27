# HAZA Room Sense

Room Sense projects are room-monitoring builds that start simple and grow only
when the extra sensors are useful.

The family exists to answer practical questions:

- Is the room comfortable?
- Is humidity drifting too high or too low?
- Is there enough light for the way the room is used?
- Would air quality, particulate sensing, movement, or presence data make better
  automations possible?

## Models

| Model | Status | What It Adds |
| --- | --- | --- |
| [Basic](basic/README.md) | Hardware-validated | Temperature, humidity, dew point, and illuminance device. |
| [Plus](plus/README.md) | Hardware-validated | Room Basic plus eCO2 and TVOC device. |
| [Air](air/README.md) | Hardware-validated | Room Plus plus Particulate Matter (PM2.5/PM10). |
| [Motion](motion/README.md) | Hardware-validated | Room Basic plus PIR. |
| [Presence](presence/README.md) | Hardware-validated | Room Motion plus Presence. |
| [Max](max/README.md) | Hardware-validated | A fully combined room sensor with all the Air, Motion, and Presence abilities. |

Each model keeps its own project files, documentation, validation evidence,
troubleshooting notes, and assets in its model folder.
