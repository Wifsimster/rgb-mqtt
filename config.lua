-- Wifi
AP = "WIFWIFI"
PWD = "192Wifsimster!!"

-- MQTT Broker
BROKER_IP = "192.168.0.35"
BROKER_PORT = 1883
CLIENT_ID = "ESP8266-"..node.chipid()
REFRESH_RATE = 300000 -- 5min

-- GPIO
RED = 5 -- GPIO_14
BLUE = 6 -- GPIO_12
GREEN = 7 -- GPIO_13
