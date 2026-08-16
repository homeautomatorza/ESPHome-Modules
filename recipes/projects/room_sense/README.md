# HAZA Room Sense

Room Sense projects are room-monitoring builds that start simple and grow only
when the extra signals are useful.

The family exists to answer practical questions:

- Is the room comfortable?
- Is humidity drifting too high or too low?
- Is there enough light for the way the room is used?
- Would air quality, particulate sensing, movement, or presence data make better
  automations possible?

## Models

| Model | Status | What It Adds |
| --- | --- | --- |
| [Basic](basic/README.md) | Available | Temperature, humidity, dew point, and illuminance. |
| [Plus](plus/README.md) | Beta | Basic plus eCO2 and TVOC. |
| [Air](air/README.md) | Beta | C6 staged air-sensing build, starting with BME280. |
| Presence | Coming soon | Movement and presence focused sensing. |
| Max | Coming soon | Reserved for the full combined room sensor. |

Each model keeps its own project files, documentation, validation evidence,
troubleshooting notes, and assets in its model folder.
