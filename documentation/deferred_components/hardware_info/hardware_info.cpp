#include "esphome/core/log.h"
#include "hardware_info.h"

namespace esphome {
namespace hardware_info {

static const char *TAG = "hardware_info.text_sensor";

void EmptyTextSensor::setup() {
  
}

void EmptyTextSensor::dump_config() { 
    ESP_LOGCONFIG(TAG, "Hardware Info");
}

}  // namespace empty_text_sensor
}  // namespace esphome