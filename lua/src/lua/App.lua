local lapis = require "lapis"
local Model = require("lapis.db.model").Model
local csrf = require "lapis.csrf"

local User = Model:extend("user")

local app = lapis.Application()

app:before_filter(function(self)
  self.csrf_token = csrf.generate_token(self)
end)

app:get("hello", "/hello", function(self)
    return "Welcome to profile"
end)

app:get("list_users", "/users", function(self)
  self.users = User:select() -- `select` all users
  return { render = true }
end)

return app