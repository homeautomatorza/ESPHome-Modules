# Room Sense Plus C6 Alt Validation

Approved by Pascal on **2026-11-12**, project version **2026.0.0**.

| Layer | Result | Evidence |
| --- | --- | --- |
| Configuration | Passed | ESPHome `2026.10.0`; all three sensors and VOC description. |
| Build | Running firmware confirmed | Pascal's device reports ESPHome `2026.11.0b3`, built 2026-11-11 at 19:09:11 +0200. |
| Physical device | Initial operation passed | ESP32-C6 Super Mini; SHT40 `0x44`, VEML7700 `0x10`, SGP40 `0x59`. |
| Home Assistant | Passed visual check | Temperature, humidity, illuminance, VOC Index and VOC description visible. |
| Documentation | Approved | Pascal approved the guide and promotion on 2026-11-12. |

## Sensor Evidence

The bus uses SDA GPIO14 and SCL GPIO18 at 50 kHz. All three addresses were
found in the supplied device log. Reporting is every 30 seconds; the SGP40
driver samples internally at 1 Hz and uses SHT40 Celsius temperature and
humidity for compensation.

The web and Home Assistant views show SHT40 temperature and humidity,
VEML7700 illuminance and SGP40 VOC Index. The three-output VEML7700 check also
showed Full Spectrum and calculated Infrared, including a valid zero IR result.
Extracting VEML7700 into a reusable package produced an identical expanded
device configuration. A different device prefix and 60-second interval also
passed a configuration check.

VOC Index Description was observed changing from “Waiting for VOC reading”
to “Below usual VOC level,” including VOC Index 89 in Home Assistant. The
at/above-baseline and invalid-value branches were checked separately in C++;
those branches were not physically exercised in the supplied captures.

## Visual Checks

- [ESPHome web-server presentation copy](../assets/device-web-server.png)
- [Home Assistant presentation copy](../assets/home-assistant-device.png)
- [Wiring diagram](../assets/wiring-diagram.png)

Private identifiers were redacted from the screenshot presentation copies using
OpenAI image editing. Unedited source evidence is retained privately. Pascal
corrected the wiring diagram's SGP40 ground connection; exact local background
cleanup preserved the breadboard/component pixels and restored the official
Fritzing wordmark.

## Scope and Limits

The running firmware supplies build evidence; a separate compiler transcript
was not supplied. The first SHT40 upload was reported as USB Serial. Later
upload methods and an OTA transfer were not established by the supplied evidence.
The device logs report OTA encryption offered with plaintext accepted.

The initial checks do not establish calibrated accuracy, long-term stability,
all deployment combinations or a certified air-quality rating. The SGP40
index and description compare with recent conditions. GPIO8 remains the board
RGB LED's strapping pin; no external pull-up/down load is shown in this build.
