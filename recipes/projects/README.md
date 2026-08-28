<p align="center">
  <img src="../../.github/images/readme/projects-hero.svg" width="100%" alt="HAZA Projects: cookbook-style ESPHome builds from practical device projects">
</p>

> [!WARNING]
> **Disclaimer:** These files are shared as-is, with the usual "it works in my
> environment" honesty baked in. They come from real builds, test
> devices, and ongoing experiments, but they are not guaranteed to work safely
> or correctly in your setup. Check the code, wiring, pins, power, secrets,
> calibration, and local rules and regulations before using anything. If it can
> switch mains power, move water, open a gate, affect safety, or ruin your
> afternoon, test it properly first.

Projects are cookbook-style ESPHome builds that show how framework packages fit
together in a real device. These often include a step-by-step guide to get you
going, plus common troubleshooting notes. I highly recommend that you
watch my [Coding practices, tips and tricks Tutorials](https://youtube.com/playlist?list=PLJ3MNJX_MOUnMWzUNDatN3LWAN8l99v5I) on YouTube to get you up to speed.

Every project on this page comes from something we built around real devices I use in my house with Home Assistant.

I recommend starting with [Room Sense Basic](room_sense/basic/README.md) on a breadboard and working from there.

## Understanding the Project Statuses

| Status | Meaning |
| --- | --- |
| Hardware-validated | Project files exist and have passed config, compile, physical upload, and live-value checks on real hardware. Check the project page for exact validation evidence. |
| Beta | Project files exist and automated validation may pass, but physical validation is still pending or incomplete. |
| Coming soon | Intended project or variant, but not ready as a public build guide yet. |
| Planned | A direction for the framework, not a build claim. |

## Available Projects

<details>

<summary> :point_right: <b>Room Sense Series</b> (9 projects) :point_left:</summary>
<br>
The <a href='room_sense/README.md'>Room Sense series</a> is for understanding how a room feels and changes over time. The first project starts small with temperature, humidity, and light.
Later variants add air quality, particulate sensing, movement, and presence
when those signals are useful. <br><br>

| Project | Status | What It Adds |
| --- | --- | --- |
| [Room Sense Basic](room_sense/basic/README.md) | Hardware-validated | Temperature, humidity, dew point, and illuminance device. |
| [Room Sense Plus](room_sense/plus/README.md) | Hardware-validated | Room Basic plus eCO2 and TVOC device. |
| [Room Sense Air](room_sense/air/README.md) | Hardware-validated | Room Plus plus particulate matter (PM2.5/PM10). |
| [Room Sense Motion](room_sense/motion/README.md) | Hardware-validated | Room Basic plus PIR. |
| [Room Sense Presence](room_sense/presence/README.md) | Hardware-validated | Room Motion plus Presence. |
| [Room Sense Max](room_sense/max/README.md) | Hardware-validated | A fully combined room sensor with all the Air, Motion, and Presence abilities. |
| Tracker Sense | Coming soon | Bluetooth-based person tracking or room presence experiments. |
| Room Remote | Coming soon | IR blaster replacement project for controlling room devices such as TVs, fans, sound systems, or air conditioners. |
| Room Sense Ultra | Coming soon | A crazy ESP32 S3-based room sensor that does it all! |

Room Sense is the sensing ladder. Room Remote is kept separate because it is a
control project, not a room-monitoring sensor. It can still use Room Sense data
later, but its main job is sending IR commands to existing room devices.

</details>

<details>

<summary><b>Weather Sense Series</b> (5 Projects)</summary>
<br>
The <a href='weather_sense/README.md'>Weather Sense series</a> is a local weather and outdoor environment monitoring system. It should stay practical: useful outdoor readings first, then more advanced measurements when the hardware and validation are ready.<br><br>

| Project | Status | Intended Direction |
| --- | --- | --- |
| [Weather Sense Basic](weather_sense/basic/README.md) | Hardware-validated | ESP32 DevKit style board, BME280, DS18B20, LTR390 UV/light, battery voltage, and sun helpers. |
| [Weather Sense Wind](weather_sense/wind/README.md) | Hardware-validated | Basic plus anemometer and wind vane. |
| [Weather Sense Wind and Rain](weather_sense/wind_and_rain/README.md) | Beta | Wind plus tipping-bucket rain gauge. |
| [Weather Sense Air](weather_sense/air/README.md) | Beta, partial hardware pass | Weather Sense Basic plus CCS811 eCO2 and TVOC air-quality sensing; CCS811 detection needs follow-up. |
| Weather Sense V4.0 | Planned | Future branch based on the Open Green Energy / PCBWay Solar Powered WiFi Weather Station V4.0 design. |
</details>

<details>

<summary><b>Hydro Sense Series</b> (3 Projects)</summary>
<br>
The <a href='hydro_sense/README.md'>Hydro Sense series</a> is for hydroponics and water-based growing
systems. It will focus on the measurements that help keep a reservoir stable and plants healthy.<br><br>

| Project | Status | Intended Direction |
| --- | --- | --- |
| [Hydro Sense Basic](hydro_sense/basic/README.md) | Scaffold | Placeholder project folder, waiting for Pascal's hardware and behavior brief. |
| Hydro Sense Plus | Planned | Adds more reservoir or plant-care signals. |
| Hydro Sense Max | Planned | Reserved for the fuller hydroponics monitoring build. |
</details>

## Future Projects

<details>

<summary><b>Tank Sense Series</b></summary>
<br>
The Tank Sense series is for larger stored-water tanks. It answers practical
household or utility questions: how much water is available, whether the tank
has reached a critical state, and what the stored water temperature is.<br><br>

| Project | Status | Intended Direction |
| --- | --- | --- |
| Tank Sense Basic | Planned | Tank level, critical-level sensor, and tank water temperature. |
| Tank Sense Plus | Planned | Basic plus a tank water flow meter. |

Tank Sense is kept separate from Hydro Sense because it is about stored-water
availability and protection, not hydroponics or plant-growing conditions. It also uses different sensors.
</details>

<details>

<summary><b>Media Series</b></summary>
<br>
The Media series is for voice, audio, and Home Assistant interaction. These projects are all about bringing voice control or media playback into any room in your house.<br><br>

| Project | Status | Intended Direction |
| --- | --- | --- |
| Voice Basic | Planned | Voice-only Home Assistant interaction. |
| Voice Plus | Planned | Voice interaction with stereo music output. |
| Music Basic | Planned | Mono audio output. |
| Music Plus | Planned | Stereo audio output. |
</details>

<details>

<summary><b>Utilities Series</b></summary>
<br>
The Utilities series is for standalone household utility monitoring where the
main job is measuring usage rather than building a larger control system.<br><br>

| Project | Status | Intended Direction |
| --- | --- | --- |
| Water Flow Basic | Planned | Utility water flow meter for tracking real-time flow and usage. |
| Power Meter Basic | Planned | Power meter for tracking real-time electricity usage. |
</details>

<details>

<summary><b>Energy Series</b></summary>
<br>
The Energy series is for inverter, plug-load, and power-system monitoring
projects. It includes both larger integrations, such as Sunsynk Modbus, and
smaller conversions that bring useful switching and power data into the
framework.<br><br>

| Project | Status | Intended Direction |
| --- | --- | --- |
| Sunsynk Link | Planned | Modbus project for real-time Sunsynk inverter data and supported control commands. |
| Smartpad Basic | Planned | Smartpad smart plug conversion with switch control and power monitoring. |
| Smartpad Tracker | Planned | Smartpad Basic plus Bluetooth-based person tracking. |

Sunsynk Link is more than a passive reader: it is being built to read from and control an 8 kW Sunsynk inverter.

Smartpad conversions should be treated as mains-powered projects. Document the
exact smart plug model, internal wiring, safety limits, and validation evidence
before publishing a build guide.
</details>
<details>

<summary><b>Relay Control Series</b></summary>
<br>
The Relay Control series is for ESPHome conversions that switch existing off-the-shelf
circuits or controllers.<br><br>

| Project | Status | Intended Direction |
| --- | --- | --- |
| Garage Door Controller | Planned | Sonoff SV conversion for low-voltage gate and garage door control. |
| Sonoff Switch Basic | Planned | Sonoff Basic conversion for controlling lights, fans, or other suitable switched loads. |
<br>
Gate and garage door projects must respect the original controller safety
features, limit switches, obstruction detection, and local regulations. Sonoff
Basic conversions should be treated as mains-powered projects and documented
with the exact model, load limits, wiring, enclosure, and validation evidence.
</details>
