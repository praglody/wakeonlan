--[[ 
Wake ON LAN
--]]

local socket_core = require("socket.core")
local string = string
local udp = socket_core.udp()
local host = arg[1] or '192.168.31.152'
local port = 9
local mac = arg[2] or '6C-4B-90-39-BE-52'
local mac_packet = ''

for w in string.gmatch(mac, "[0-9A-Za-z][0-9A-Za-z]") do
    mac_packet = mac_packet .. string.char(tonumber(w, 16))
end

mac_packet = string.char(0xff):rep(6) .. mac_packet:rep(16)

udp:settimeout(3)

udp:setpeername(host, port)
local udpsend = udp:send(mac_packet)

if udpsend then
    print("wake up success")
else
    print("wake up error")
end
