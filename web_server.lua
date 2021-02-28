ledPin = 1
gpio.mode(ledPin, gpio.OUTPUT)
gpio.write(ledPin, gpio.LOW)
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
  conn:on("receive", function(client,request)
    local buf = ""
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if(method == nil)then
      _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    local _GET = {}
    if (vars ~= nil)then
      for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        _GET[k] = v
      end
    end
    buf = buf.."<!DOCTYPE HTML><html> \
    <head> \
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \
      <title>Esp 8266 Web Server</title> \
      <style> \
        html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;} \
        .button { background-color: #4CAF50; border: none; color: white; padding: 16px 40px; \
        text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;} \
        .button2 {background-color: #555555;} \
      </style> \
    </head> \
    <body> \
      <h1> ESP 8266 Web server</h1>"
    if(_GET.pin == "ON")then
        gpio.write(ledPin, gpio.HIGH)
    elseif(_GET.pin == "OFF")then
        gpio.write(ledPin, gpio.LOW)
    end
    local pinState = gpio.read(ledPin)
    if(pinState == gpio.HIGH)then
      buf = buf.."<p>Ventilador ligado</p> \
      <p><a href=\"/?pin=OFF\"><button class=\"button button2\">Desligar</button></a></p>"
    else
      buf = buf.."<p>Ventilador desligado</p> \
      <p><a href=\"/?pin=ON\"><button class=\"button\">Ligar</button></a></p>"
    end
    buf = buf.."</body></html>"
    client:send(buf)
  end)
  conn:on("sent", function (c) c:close() end)
end)
