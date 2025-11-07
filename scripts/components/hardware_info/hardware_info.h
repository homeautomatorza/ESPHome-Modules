#pragma once

#include "esphome/core/component.h"
// #include "esphome/components/text_sensor/text_sensor.h"

namespace esphome {
namespace hardware_info {

class HardwareInfo : public text_sensor::TextSensor, public Component {
 public:
  void setup() override;
  void dump_config() override;
};

}  // namespace hardware_info
}  // namespace esphome