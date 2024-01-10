http = require 'socket.http'
ltn12 = require 'ltn12'

apiUrl = "http://localhost:8085/category"

function getCategories(url)
  local response = {}
  local _, statusCode, headers, statusText = http.request {
    url = url,
    sink = ltn12.sink.table(response),
  }

  print("Status Code:", statusCode)
  print("Headers:", headers)
  print("Status Text:", statusText)
  print("Response Body:", table.concat(response))
end

getCategories(apiUrl)