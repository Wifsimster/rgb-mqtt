require('config')
    
-- SET GPIO to OUTPUT
gpio.mode(BLUE, gpio.OUTPUT)
gpio.mode(GREEN, gpio.OUTPUT)
gpio.mode(RED, gpio.OUTPUT)

-- Init GPIO at boot
gpio.write(BLUE, gpio.LOW);
gpio.write(GREEN, gpio.LOW);
gpio.write(RED, gpio.LOW);

print("Starting ESP"..node.chipid().."...")

wifi.setmode(wifi.STATION)
wifi.sta.config(AP,PWD)

print('MAC address:', wifi.sta.getmac())

tmr.create():alarm(1000, tmr.ALARM_AUTO, function(cb_timer)
    if wifi.sta.getip() == nil then
        print("Waiting for IP address...")
    else
        cb_timer:unregister()
        print("WiFi connection established, IP address: " .. wifi.sta.getip())
        if file.open("main.lua") ~= nil then
            dofile("main.lua")
        else 
            print("main.lua doesn't exist !")
        end
    end
end)