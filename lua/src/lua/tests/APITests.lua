local http = require('socket.http')
local ltn12 = require('ltn12')
local cjson = require("cjson.safe")

local global_id = nil

local function send_request(method, url, params)
    local request_body = ""
    if params then
        for key, value in pairs(params) do
            if #request_body > 0 then
                request_body = request_body .. "&"
            end
            request_body = request_body .. key .. "=" .. value
        end
    end

    local response_body = {}
    local _, status_code, _, _ = http.request {
        url = url,
        method = method,
        headers = { ['Content-Type'] = 'application/x-www-form-urlencoded' },
        source = ltn12.source.string(request_body),
        sink = ltn12.sink.table(response_body)
    }

    return status_code, table.concat(response_body)
end

function post_test()
    local post_url = "http://172.24.164.140:8085/add-product"
    local post_params = {
        name = "TEST",
        category = "2",
        price = "3",
        description = "TEST123123",
        available = "1"
    }

    local post_status, post_response = send_request("POST", post_url, post_params)
    print("POST Status Code:", post_status)
    print("POST Response:", post_response)
end

function put_test()
    local last = get_last_product()
    local id = last.id
    print(id)
    local put_url = "http://172.24.164.140:8085/update-product?id=" .. tostring(id)
    local put_params = {
        name = "TEST2",
        category = "3",
        price = "3",
        description = "TEST919191919asdasd",
        available = "1"
    }
    local put_status, put_response = send_request("PUT", put_url, put_params)
    print("PUT Status Code:", put_status)
    print("PUT Response:", put_response)
end

function get_test()
    local get_url = "http://172.24.164.140:8085/get-product/" .. tostring(global_id)
    local get_status, get_response = send_request("GET", get_url)
    print("GET Status Code:", get_status)
    print("GET Response:", get_response)
end

function delete_test()
    local delete_url = "http://172.24.164.140:8085/delete-product/" .. tostring(global_id)
    local delete_status, delete_response = send_request("DELETE", delete_url)
    print("DELETE Status Code:", delete_status)
    print("DELETE Response:", delete_response)
end

function get_last_product()
    local get_last_product_url = "http://172.24.164.140:8085/get-last-product"
    local get_last_product_status, get_last_product_response = send_request("GET", get_last_product_url)
    if get_last_product_status == 200 then
        local last_product = cjson.decode(get_last_product_response)
        global_id = last_product[1].id
        return last_product[1]
    else
        return nil
    end
end 

post_test()
put_test()
get_test()
delete_test()
print("Test passed successfully!")