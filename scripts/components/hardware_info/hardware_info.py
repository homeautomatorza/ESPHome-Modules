import esphome.codegen as cg
import esphome.config_validation as cv
from esphome.components import text_sensor

hardware_info = cg.esphome_ns.namespace("hardware_info")
HardwareInfo = empty_text_sensor_ns.class_(
    "HardwareInfo", text_sensor.TextSensor, cg.Component
)

CONFIG_SCHEMA = text_sensor.text_sensor_schema(HardwareInfo).extend(
    cv.COMPONENT_SCHEMA
)

async def to_code(config):
    var = await text_sensor.new_text_sensor(config)
    await cg.register_component(var, config)