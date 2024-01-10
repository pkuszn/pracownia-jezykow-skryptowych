local lapis = require "lapis"
local Model = require("lapis.db.model").Model
local csrf = require "lapis.csrf"
local capture_errors = require("lapis.application").capture_errors

local category = Model:extend("category")
local purchase = Model:extend("purchase")
local product = Model:extend("product")
local delivery_type = Model:extend("delivery_type")
local payment_type = Model:extend("payment_type")
local user = Model:extend("user")

local app = lapis.Application()

app:before_filter(function(self)
  self.csrf_token = csrf.generate_token(self)
end)

app:get("hello", "/hello", function(self)
    return "Welcome to profile"
end)

-- Category

app:get("category", "/category", function(self)
  local response = category:select()
  return { json = response }
end)

app:get("category", "/category/:id", function(self)
  local id = tonumber(self.params.id)

  if not id then
    return { json = { error = "Invalid ID" }, status = 400 }
  end

  local category = category:find(id)

  if not category then
    return { json = { error = "Category not found" }, status = 404 }
  end
  
  return { json = category }
end)

-- PaymentType

app:get("payment_type", "/payment-type", function(self)
  local response = payment_type:select()
  return { json = response }
end)

app:get("payment_type", "/payment-type/:id", function(self)
  local id = tonumber(self.params.id)

  if not id then
    return { json = { error = "Invalid ID" }, status = 400 }
  end

  local payment_type = payment_type:find(id)

  if not payment_type then
    return { json = { error = "Payment Type not found" }, status = 404 }
  end
  
  return { json = payment_type }
end)


-- DeliveryType

app:get("delivery_type", "/delivery-type", function(self)
  local response = delivery_type:select()
  return { json = response }
end)

app:get("delivery_type", "/delivery-type/:id", function(self)
  local id = tonumber(self.params.id)

  if not id then
    return { json = { error = "Invalid ID" }, status = 400 }
  end

  local delivery_type = delivery_type:find(id)

  if not delivery_type then
    return { json = { error = "Delivery Type not found" }, status = 404 }
  end
  
  return { json = delivery_type }
end)


-- Purchase

app:get("purchase", "/purchase", function(self)
  local purchases = purchase:select()
  if not purchases or #purchases == 0 then
      return { status = 404, json = "No purchases found."}
  end
  return { status = 200, json = purchases } 
end)

app:get("purchase", "/purchase/:id", function(self)
  local purchase = purchase:find(self.params.id)
  if not purchase then
      return { status = 404, json = { message = "Cannot find specified purchase." } }
  end
end)

app:post("purchase", "/purchase", function(self)
  local purchaseParams = self.params.purchase
  local purchase = purchase:create(purchaseParams)
  return { status = 201, json = purchase }
end)

app:put("purchase", "/purchase/:id", function(self)
  local purchaseParams = self.params.purchase
  local purchase = purchase:find(self.params.id)
  if not purchase then
      return { status = 404, json = { message = "Purchase not found." } }
  end
  purchase:update(purchaseParams)
  return { status = 204, json = purchase }
end)

app:delete("purchase", "/purchase/:id", function(self)
  local purchase = purchase:find(self.params.id)
  if not purchase then
      return { status = 404, json = { message = "Purchase not found" } }
  end
  purchase:delete()
  return { status = 204 }
end)

-- Product

app:get("product", "/product", function(self)
  local products = product:select()
  if not products or #products == 0 then
      return { status = 404, json = "No products types found."}
  end
  return { status = 200, json = products } 
end)

app:get("product", "/product/:id", function(self)
  local product = product:find(self.params.id)
  if not product then
      return { status = 404, json = { message = "Cannot find specified product." } }
  end
end)

app:post("product", "/product", capture_errors(function(self)
  csrf.assert_token(self)

  local payload = self.params

  if not payload then
    return { status = 404 }
  end

  product:insert({
    name = payload.name,
    category = payload.category,
    price = payload.price,
    created_date = os.date("%Y-%m-%dT%H:%M:%SZ"),  
    description = payload.description,
    available = payload.available
  })

  return { status = 201 }
end))

app:post("example_route", "/example", function(self)
  local payload = self.params

  -- Access data from the payload
  local name = payload.name
  local age = payload.age

  return { json = { message = "Data received successfully" } }
end)

app:put("product", "/product/:id", function(self)
  local productParams = self.params.product
  local product = product:find(self.params.id)
  if not product then
      return { status = 404, json = { message = "Product not found." } }
  end
  product:update(productParams)
  return { status = 204, json = product }
end)

app:delete("product", "/product/:id", function(self)
  local product = product:find(self.params.id)
  if not product then
      return { status = 404, json = { message = "Product not found" } }
  end
  product:delete()
  return { status = 204 }
end)

-- User

app:get("user", "/user", function(self)
  local users = user:select()
  if not users or #users == 0 then
      return { status = 404, json = "No users found."}
  end
  return { status = 200, json = users } 
end)

app:get("user", "/user/:id", function(self)
  local user = user:find(self.params.id)
  if not user then
      return { status = 404, json = { message = "Cannot find specified user." } }
  end
end)

app:post("user", "/user", function(self)
  local userParams = self.params.user
  local user = user:create(self.userParams)
  return { status = 201, json = user }
end)

app:put("user", "/user/:id", function(self)
  local userParams = self.params.user
  local user = user:find(self.params.id)
  if not user then
      return { status = 404, json = { message = "User not found." } }
  end
  user:update(userParams)
  return { status = 204, json = user }
end)

app:delete("user", "/user/:id", function(self)
  local user = user:find(self.params.id)
  if not user then
      return { status = 404, json = { message = "User not found" } }
  end
  user:delete()
  return { status = 204 }
end)


return app