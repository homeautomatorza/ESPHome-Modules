# HAZA Weather Sense

Weather Sense projects are local outdoor monitoring builds. The first pass is
based on the
[Open Green Energy Solar Powered WiFi Weather Station V3.0](https://www.opengreenenergy.com/solar-powered-wifi-weather-station-v3-0/)
hardware design.

The original Open Green Energy project provides C++ firmware. Pascal converted
that idea to ESPHome for his own station, and this cookbook turns that older
flat ESPHome file into a staged HAZA project family. We start with the station
body and the quiet sensors, then add air quality for the current Air candidate.
Wind and rain move to the later V4 weather-meter path where the moving hardware
can be tested properly.

The family exists to answer practical questions:

- What are the conditions right here, not at the nearest airport?
- Is the station powered and healthy?
- Is wind, rain, UV, or air-quality data worth adding to this location?
- Can this data help with irrigation, ventilation, garden planning, or local
  weather history?

For now, **Weather Sense Air** is the current production-facing target. Basic
proves the board and quiet sensors. Air adds the current air-quality stack, but
the CCS811 hardware detection still needs a follow-up pass. Wind and Wind and
Rain remain staged bring-up branches for later hardware work.

## Models

| Model | Status | What It Adds |
| --- | --- | --- |
| [Basic](basic/README.md) | Beta | HAZA Weather Station Board v1, BME280, DS18B20, LTR390 UV/light, battery voltage, and sun helpers. |
| [Wind](wind/README.md) | Beta | Basic plus anemometer and wind vane. |
| [Wind and Rain](wind_and_rain/README.md) | Beta | Wind plus tipping-bucket rain gauge. |
| [Air](air/README.md) | Beta, partial hardware pass | Basic plus CCS811 eCO2 and TVOC air-quality sensing; CCS811 detection needs follow-up. |

## Future Hardware Branches

After Weather Sense Air is working, two later branches are planned:

- A new version based on the Open Green Energy / PCBWay
  [Solar Powered WiFi Weather Station V4.0](https://www.pcbway.com/project/shareproject/https_www_instructables_com_Solar_Powered_WiFi_Weather_Station_V40_515ff597.html)
  design.
- A later version based on Pascal's own weather station board design.

Each model keeps its own project files, documentation, validation evidence,
troubleshooting notes, and assets in its model folder.
