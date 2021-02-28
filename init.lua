-- Arquivo de inicialização do ESP

-- Configura wifi
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="Rede WIFI"
station_cfg.pwd="qualasenhadowifi"
wifi.sta.config(station_cfg)

-- register event callbacks for WiFi events
wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T)
  print("\n\tSTA - CONNECTED".."\n\tSSID: "..T.SSID.."\n\tBSSID: "..
  T.BSSID.."\n\tChannel: "..T.channel)
end)

wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function(T)
  print("\n\tSTA - DISCONNECTED".."\n\tSSID: "..T.SSID.."\n\tBSSID: "..
  T.BSSID.."\n\treason: "..T.reason)
end)

wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, function(T)
  print("\n\tSTA - AUTHMODE CHANGE".."\n\told_auth_mode: "..
  T.old_auth_mode.."\n\tnew_auth_mode: "..T.new_auth_mode)
end)

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
  print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP.."\n\tSubnet mask: "..
  T.netmask.."\n\tGateway IP: "..T.gateway)
  dofile("web_server.lua")
end)

wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, function()
  print("\n\tSTA - DHCP TIMEOUT")
end)

wifi.eventmon.register(wifi.eventmon.WIFI_MODE_CHANGED, function(T)
  print("\n\tSTA - WIFI MODE CHANGED".."\n\told_mode: "..
  T.old_mode.."\n\tnew_mode: "..T.new_mode)
end)
