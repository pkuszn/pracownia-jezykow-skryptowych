lapis = require("lapis")
Application = require("lapis.application")

app = Application:extend()

app:match("/product", "controllers.product_controller.index")
app:match("/product/:id", "controllers.product_controller.show")
app:post("/product", "controllers.product_controller.create")
app:patch("/product/:id", "controllers.product_controller.update")
app:delete("/product/:id", "controllers.product_controller.destroy")

app:match("/category", "controllers.category_controller.index")
app:match("/category/:id", "controllers.category_controller.show")

app:match("/delivery-type", "controllers.delivery_type_controller.index")
app:match("/delivery-type/:id", "controllers.delivery_type_controller.show")

app:match("/payment-type", "controllers.payment_type_controller.index")
app:match("/payment-type/:id", "controllers.payment_type_controller.show")

app:match("/purchase", "controllers.purchase_controller.index")
app:match("/purchase/:id", "controllers.purchase_controller.show")
app:post("/purchase", "controllers.purchase_controller.create")
app:patch("/purchase/:id", "controllers.purchase_controller.update")
app:delete("/purchase/:id", "controllers.purchase_controller.destroy")

app:match("/users", "controllers.user_controller.index")
app:match("/users/:id", "controllers.user_controller.show")
app:post("/users", "controllers.user_controller.create")
app:patch("/users/:id", "controllers.user_controller.update")
app:delete("/users/:id", "controllers.user_controller.destroy")

return app
