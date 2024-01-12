local config
config = require("lapis.config").config
return config("development", function()
  return mysql(function()
    host("127.0.0.1")
    user("root")
    password("root")
    return database("shop")
  end)
end)
