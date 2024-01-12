local lapis = require("lapis")
local Model
Model = require("lapis.db.model").Model
local csrf = require("lapis.csrf")
local capture_errors = require("lapis.application").capture_errors
local respond_to
respond_to = require("lapis.application").respond_to
local json_params
json_params = require("lapis.application").json_params
local Category
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
    __name = "Category",
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
  Category = _class_0
end
local PaymentType
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
    __name = "PaymentType",
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
  PaymentType = _class_0
end
local DeliveryType
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
    __name = "DeliveryType",
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
  DeliveryType = _class_0
end
local Product
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
    __name = "Product",
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
  Product = _class_0
end
local Purchase
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
    __name = "Purchase",
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
  Purchase = _class_0
end
local User
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
    __name = "User",
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
  User = _class_0
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
    ["/get-categories"] = respond_to({
      GET = function(self)
        self.user = Category:select()
        if not (self.user) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.user
        }
      end
    }),
    ["/get-category/:id"] = respond_to({
      GET = function(self)
        self.user = Category:find({
          id = self.params.id
        })
        if not (self.user) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.user
        }
      end
    }),
    ["/get-payment-types"] = respond_to({
      GET = function(self)
        self.payment_type = PaymentType:select()
        if not (self.payment_type) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.payment_type
        }
      end
    }),
    ["/get-payment-type/:id"] = respond_to({
      GET = function(self)
        self.payment_type = PaymentType:find({
          id = self.params.id
        })
        if not (self.payment_type) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.payment_type
        }
      end
    }),
    ["/get-delivery-types"] = respond_to({
      GET = function(self)
        self.delivery_type = DeliveryType:select()
        if not (self.delivery_type) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.delivery_type
        }
      end
    }),
    ["/get-delivery-type/:id"] = respond_to({
      GET = function(self)
        self.delivery_type = DeliveryType:find({
          id = self.params.id
        })
        if not (self.delivery_type) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.delivery_type
        }
      end
    }),
    ["/products"] = respond_to({
      GET = function(self)
        self.product = Product:select()
        if not (self.product) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.product
        }
      end,
      POST = json_params(function(self)
        self.product = Product:create({
          name = self.params.name,
          category = tonumber(self.params.category),
          price = tonumber(self.params.price),
          created_date = os.date("%Y-%m-%d"),
          description = self.params.description,
          available = not not self.params.available
        })
        return {
          json = self.product
        }
      end)
    }),
    ["/product"] = respond_to({
      PUT = json_params(function(self)
        self.product = Product:find({
          id = self.params.id
        })
        if not (self.product) then
          self:write({
            status = 404
          }, "Not Found")
        end
        self.product:update(self.params)
        return {
          json = self.product
        }
      end)
    }),
    ["/product/:id"] = respond_to({
      GET = function(self)
        self.product = Product:find({
          id = self.params.id
        })
        if not (self.product) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.product
        }
      end,
      DELETE = function(self)
        self.product = Product:find({
          id = self.params.id
        })
        if not (self.product) then
          self:write({
            status = 404
          }, "Not Found")
        end
        self.product:delete()
        return {
          json = "Item deleted"
        }
      end
    }),
    ["/purchases"] = respond_to({
      GET = function(self)
        self.purchase = Purchase:select()
        if not (self.purchase) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.purchase
        }
      end,
      POST = json_params(function(self)
        self.purchase = Purchase:create({
          id_product = tonumber(self.params.id_product),
          id_user = tonumber(self.params.id_user),
          price = tonumber(self.params.price),
          quantity = tonumber(self.params.quantity),
          purchase_date = os.date("%Y-%m-%d"),
          delivery_type = tonumber(self.params.delivery_type),
          payment_type = tonumber(self.params.payment_type)
        })
        return {
          json = self.purchase
        }
      end)
    }),
    ["/purchase"] = respond_to({
      PUT = json_params(function(self)
        self.purchase = Purchase:find({
          id = self.params.id
        })
        if not (self.purchase) then
          self:write({
            status = 404
          }, "Not Found")
        end
        self.purchase:update(self.params)
        return {
          json = self.purchase
        }
      end)
    }),
    ["/purchase/:id"] = respond_to({
      GET = function(self)
        self.purchase = Purchase:find({
          id = self.params.id
        })
        if not (self.purchase) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.purchase
        }
      end,
      DELETE = function(self)
        self.purchase = Purchase:find({
          id = self.params.id
        })
        if not (self.purchase) then
          self:write({
            status = 404
          }, "Not Found")
        end
        self.purchase:delete()
        return {
          json = "Item deleted"
        }
      end
    }),
    ["/users"] = respond_to({
      GET = function(self)
        self.user = User:select()
        if not (self.user) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.user
        }
      end,
      POST = json_params(function(self)
        self.user = User:create({
          name = self.params.name,
          surname = self.params.surname,
          password = self.params.password,
          address = self.params.address,
          created_date = os.date("%Y-%m-%d")
        })
        return {
          json = self.user
        }
      end)
    }),
    ["/user"] = respond_to({
      PUT = function(self)
        self.user = User:find({
          id = self.params.id
        })
        if not (self.user) then
          self:write({
            status = 404
          }, "Not Found")
        end
        self.user:update(self.params)
        return {
          json = self.user
        }
      end
    }),
    ["/user/:id"] = respond_to({
      GET = function(self)
        self.user = User:find({
          id = self.params.id
        })
        if not (self.user) then
          self:write({
            status = 404
          }, "Not Found")
        end
        return {
          json = self.user
        }
      end,
      DELETE = function(self)
        self.user = User:find({
          id = self.params.id
        })
        if not (self.user) then
          self:write({
            status = 404
          }, "Not Found")
        end
        self.user:delete()
        return {
          json = "Item deleted"
        }
      end
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
