require('config')

TOPIC = "/sensors/rgb/data"

-- Init client with keepalive timer 120sec
m = mqtt.Client(CLIENT_ID, 120, "", "")

ip = wifi.sta.getip()

m:lwt("/offline", '{"message":"'..CLIENT_ID..'", "topic":"'..TOPIC..'", "ip":"'..ip..'"}', 0, 0)

print("Connecting to MQTT: "..BROKER_IP..":"..BROKER_PORT.."...")

m:connect(BROKER_IP, BROKER_PORT, 0, 1, function(conn)
    print("Connected to MQTT: "..BROKER_IP..":"..BROKER_PORT.." as "..CLIENT_ID)

    m:subscribe(TOPIC, 0, function(client)
        print("Successfully subscribed to the topic: "..TOPIC)
    end)

    m:on("message", function(conn, topic, data)
        if(data == 'BLUE') then
            gpio.write(BLUE, gpio.HIGH);
        end
        if(data == 'GREEN') then
            gpio.write(GREEN, gpio.HIGH);
        end
        if(data == 'RED') then
            gpio.write(RED, gpio.HIGH);
        end
        if(data == 'OFF') then
            print('OFF')
            gpio.write(BLUE, gpio.LOW);
            gpio.write(GREEN, gpio.LOW);
            gpio.write(RED, gpio.LOW);
        end
        if(data == 'ALL') then
            print('ALL')
            gpio.write(BLUE, gpio.HIGH);
            gpio.write(GREEN, gpio.HIGH);
            gpio.write(RED, gpio.HIGH);
        end
    end)    
end)
