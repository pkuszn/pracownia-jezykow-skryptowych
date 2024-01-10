local http = require('socket.http')
local ltn12 = require('ltn12')

local r = {}
http.request {
    url = 'http://localhost:8085/category/1',
    headers = {['x-accept'] = 'donates'},
    sink = ltn12.sink.table(r)
}
print(r[1])
