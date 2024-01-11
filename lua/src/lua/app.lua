local lapis = require "lapis"
local Model = require("lapis.db.model").Model
local csrf = require "lapis.csrf"
local capture_errors = require("lapis.application").capture_errors

local category = require("models.category")
local purchase = require("models.purchase")
local product = require("models.product")
local delivery_type = require("models.delivery_type")
local payment_type = require("models.payment_type")
local user = require("models.user")

local app = lapis.Application()

app:before_filter(function(self)
  self.csrf_token = csrf.generate_token(self)
end)

app:get("hello", "/hello", function(self)
    return "Welcome to profile"
end)

-- Category

app:get("get_categories", "/get-category", function(self)
  local response = category:select()
  return { json = response }
end)

app:get("get_category", "/get-category/:id", function(self)
  local id = tonumber(self.params.id)

  if not id then
    return { json = { error = "Invalid ID" }, status = 400 }
  end

  local category = category:find({id = id})

  if not category then
    return { json = { error = "Category not found" }, status = 404 }
  end
  
  return { json = category }
end)

-- PaymentType

app:get("get_payment_types", "/get-payment-type", function(self)
  local response = payment_type:select()
  return { json = response }
end)

app:get("get_payment_type", "/get-payment-type/:id", function(self)
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

app:get("get_delivery_types", "/get-delivery-type", function(self)
  local response = delivery_type:select()
  return { json = response }
end)

app:get("get_delivery_type", "/get-delivery-type/:id", function(self)
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

app:get("get_purchases", "/get-purchase", function(self)
  local purchases = purchase:select()
  if not purchases or #purchases == 0 then
      return { status = 404, json = "No purchases found."}
  end
  return { status = 200, json = purchases } 
end)

app:get("get_purchase", "/get-purchase/:id", function(self)
  local id = tonumber(self.params.id)

  if not id then
    return { json = { error = "Invalid ID" }, status = 400 }
  end

  local purchase = purchase:find({id = id})

  if not purchase then
    return { json = { error = "Purchase not found" }, status = 404 }
  end
  
  return { json = purchase }
end)

app:post("add_purchase", "/add-purchase", function(self)
  local payload = self.params

  if not payload then
    return { status = 404 }
  end

  purchase:create({
    id_product = tonumber(payload.id_product),
    id_user = tonumber(payload.id_user),
    price = tonumber(payload.price),
    purchase_date =  os.date("%Y-%m-%d"),
    quantity = tonumber(payload.quantity),
    delivery_type = tonumber(payload.delivery_type),
    payment_type = tonumber(payload.payment_type)
  })

  return { status = 201 }
end)

app:put("update_purchase", "/update-purchase/:id", function(self)
  local payload = self.params

  if not payload then
    return { status = 404 }
  end

  local purchase = purchase:find(tonumber(payload.id))
  if not purchase then
      return { status = 404, json = { message = "Purchase not found." } }
  end

  local update_purchase = {
    id = tonumber(payload.id),
    id_product = tonumber(payload.id_product),
    id_user = tonumber(payload.id_user),
    price = tonumber(payload.price),
    purchase_date =  os.date("%Y-%m-%d"),
    quantity = tonumber(payload.quantity),
    delivery_type = tonumber(payload.delivery_type),
    payment_type = tonumber(payload.payment_type)
  }

  product:update(update_purchase)
  return { status = 204, json = update_purchase }
end)

app:delete("delete_purchase", "/delete-purchase/:id", function(self)
  local purchase = purchase:find(tonumber(self.params.id))
  if not purchase then
      return { status = 404, json = { message = "Purchase not found" } }
  end
  purchase:delete(purchase)
  return { status = 204 }
end)

-- Product

app:get("get_products", "/get-product", function(self)
  local products = product:select()
  if not products or #products == 0 then
      return { status = 404, json = "No products types found."}
  end
  return { status = 200, json = products } 
end)

app:get("get_product", "/get-product/:id", function(self)
  local id = tonumber(self.params.id)

  if not id then
    return { json = { error = "Invalid ID" }, status = 400 }
  end

  local product = product:find({id = id})

  if not product then
    return { json = { error = "Product not found" }, status = 404 }
  end
  
  return { json = product }
end)


app:post("add_product", "/add-product", function(self)
  local payload = self.params

  if not payload then
    return { status = 404 }
  end

  product:create({
    name = payload.name,
    category = tonumber(payload.category),
    price = tonumber(payload.price),
    created_date = os.date("%Y-%m-%d"),  
    description = payload.description,
    available = not not payload.available
  })

  return { status = 201 }
end)

app:put("update_product", "/update-product", function(self)
  local payload = self.params

  if not payload then
    return { status = 404 }
  end

  local product = product:find(tonumber(payload.id))
  if not product then
      return { status = 404, json = { message = "Product not found." } }
  end

  local update_product = {
    id = tonumber(payload.id),
    name = payload.name,
    category = payload.category,
    price = tonumber(payload.price),
    created_date = os.date("%Y-%m-%d"),
    description = payload.description,
    available = not not payload.available
  }

  product:update(update_product)
  return { status = 204, json = update_product }
end)

app:delete("delete_product", "/delete-product/:id", function(self)
  local product = product:find(tonumber(self.params.id))
  if not product then
      return { status = 404, json = { message = "Product not found" } }
  end
  product:delete(product)
  return { status = 204 }
end)

-- User

app:get("get_users", "/get-user", function(self)
  local users = user:select()
  if not users or #users == 0 then
      return { status = 404, json = "No users found."}
  end
  return { status = 200, json = users } 
end)

app:get("get_user", "/get-user/:id", function(self)
  local id = tonumber(self.params.id)

  if not id then
    return { json = { error = "Invalid ID" }, status = 400 }
  end

  local user = user:find({id = id})

  if not user then
    return { json = { error = "User not found" }, status = 404 }
  end
  
  return { json = user }
end)

app:post("add_user", "/add-user", function(self)
  local payload = self.params

  if not payload then
    return { status = 404 }
  end

  user:create({
    name = payload.name,
    surname = payload.surname,
    password = payload.password,
    address = payload.address,
    created_date = os.date("%Y-%m-%d")
  })

  return { status = 201 }
end)

app:put("update_user", "/update-user/:id", function(self)
  local payload = self.params

  if not payload then
    return { status = 404 }
  end

  local user = user:find(tonumber(payload.id))
  if not user then
      return { status = 404, json = { message = "Product not found." } }
  end

  local update_user = {
    id = tonumber(payload.id),
    name = payload.name,
    surname = payload.surname,
    password = payload.password,
    address = payload.address,
    created_date = os.date("%Y-%m-%d")
  }

  product:update(update_user)
  return { status = 204, json = update_user }
end)

app:delete("delete_user", "/delete-user/:id", function(self)
  local user = user:find(self.params.id)
  if not user then
      return { status = 404, json = { message = "User not found" } }
  end
  user:delete()
  return { status = 204 }
end)


return app