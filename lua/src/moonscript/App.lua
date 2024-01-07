local lapis = require("lapis")
local Application = require("lapis.application")
local app = {
  Application = extend()
}
local _ = {
  app = match("/product", "controllers.product_controller.index")
}
_ = {
  app = match("/product/:id", "controllers.product_controller.show")
}
_ = {
  app = post("/product", "controllers.product_controller.create")
}
_ = {
  app = patch("/product/:id", "controllers.product_controller.update")
}
_ = {
  app = delete("/product/:id", "controllers.product_controller.destroy")
}
_ = {
  app = match("/category", "controllers.category_controller.index")
}
_ = {
  app = match("/category/:id", "controllers.category_controller.show")
}
_ = {
  app = match("/delivery-type", "controllers.delivery_type_controller.index")
}
_ = {
  app = match("/delivery-type/:id", "controllers.delivery_type_controller.show")
}
_ = {
  app = match("/payment-type", "controllers.payment_type_controller.index")
}
_ = {
  app = match("/payment-type/:id", "controllers.payment_type_controller.show")
}
_ = {
  app = match("/purchase", "controllers.purchase_controller.index")
}
_ = {
  app = match("/purchase/:id", "controllers.purchase_controller.show")
}
_ = {
  app = post("/purchase", "controllers.purchase_controller.create")
}
_ = {
  app = patch("/purchase/:id", "controllers.purchase_controller.update")
}
_ = {
  app = delete("/purchase/:id", "controllers.purchase_controller.destroy")
}
_ = {
  app = match("/users", "controllers.user_controller.index")
}
_ = {
  app = match("/users/:id", "controllers.user_controller.show")
}
_ = {
  app = post("/users", "controllers.user_controller.create")
}
_ = {
  app = patch("/users/:id", "controllers.user_controller.update")
}
_ = {
  app = delete("/users/:id", "controllers.user_controller.destroy")
}
return app
