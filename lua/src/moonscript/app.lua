local lapis = require("lapis")
local Model = require("lapis.db.model").Model
local csrf = require("lapis.csrf")
local capture_errors = require("lapis.application").capture_errors
local respond_to
respond_to = require("lapis.application").respond_to
local category
do
  local _class_0
  local _parent_0 = Model
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "category",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  category = _class_0
end
local App
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    ["/hello"] = respond_to({
      GET = function(self)
        return {
          json = "hello world"
        }
      end
    }),
    ["/get_category"] = respond_to({
      before = function(self)
        do
          local _base_1 = category
          local _fn_0 = _base_1.select
          self.user = function(...)
            return _fn_0(_base_1, ...)
          end
        end
        if not (self.user) then
          return self:write({
            status = 404
          }, "Not Found")
        end
      end,
      GET = function(self)
        return {
          json = self.user
        }
      end
    }, {
      ["/get_category/:id"] = respond_to({
        before = function(self)
          self.user = category:find(self.params.id)
          if not (self.user) then
            return self:write({
              status = 404
            }, "Not Found")
          end
        end,
        GET = function(self)
          return {
            json = self.user
          }
        end
      })
    })
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "App",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  App = _class_0
  return _class_0
end
