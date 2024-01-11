lapis = require("lapis")
Model = require("lapis.db.model").Model
csrf = require "lapis.csrf"
capture_errors = require("lapis.application").capture_errors
import respond_to from require "lapis.application"

class category extends Model
    -- purchase = Model.extend 'purchase'
-- product = Model.extend 'product'
-- delivery_type = Model.extend 'delivery_type'
-- payment_type = Model.extend 'payment_type'
-- user = Model.extend 'user'

class App extends lapis.Application
    "/hello": respond_to {
        GET: =>
            { json: "hello world"}
      }

    "/get_category": respond_to {
        before: =>
            @user = category\select
            @write status: 404, "Not Found" unless @user
    
        GET: =>
            {json: @user }
      }

      "/get_category/:id": respond_to {
        before: =>
            @user = category\find @params.id
            @write status: 404, "Not Found" unless @user
    
        GET: =>
          { json: @user }
      }



-- app:get "hello", "/hello", ->
--   "Welcome to profile"

-- -- Category

-- app:get "get_categories", "/get-category", ->
--   {json: category:select()}

-- app:get "get_category", "/get-category/:id", ->
--   id = tonumber @params.id
--   return {json: {error: "Invalid ID"}, status: 400} unless id
--   category_info = category:find {id}
--   return {json: {error: "Category not found"}, status: 404} unless category_info
--   {json: category_info}

-- -- PaymentType

-- app:get "get_payment_types", "/get-payment-type", ->
--   {json: payment_type:select()}

-- app:get "get_payment_type", "/get-payment-type/:id", ->
--   id = tonumber @params.id
--   return {json: {error: "Invalid ID"}, status: 400} unless id
--   payment_type_info = payment_type:find id
--   return {json: {error: "Payment Type not found"}, status: 404} unless payment_type_info
--   {json: payment_type_info}

-- -- DeliveryType

-- app:get "get_delivery_types", "/get-delivery-type", ->
--   {json: delivery_type:select()}

-- app:get "get_delivery_type", "/get-delivery-type/:id", ->
--   id = tonumber @params.id
--   return {json: {error: "Invalid ID"}, status: 400} unless id
--   delivery_type_info = delivery_type:find id
--   return {json: {error: "Delivery Type not found"}, status: 404} unless delivery_type_info
--   {json: delivery_type_info}

-- -- Purchase

-- app:get "get_purchases", "/get-purchase", ->
--   purchases = purchase:select()
--   return {status: 404, json: "No purchases found."} unless purchases or #purchases > 0
--   {status: 200, json: purchases}

-- app:get "get_purchase", "/get-purchase/:id", ->
--   id = tonumber @params.id
--   return {json: {error: "Invalid ID"}, status: 400} unless id
--   purchase_info = purchase:find {id}
--   return {json: {error: "Purchase not found"}, status: 404} unless purchase_info
--   {json: purchase_info}

-- app:post "add_purchase", "/add-purchase", ->
--   payload = @params
--   return {status: 404} unless payload
--   purchase:create {
--     id_product: tonumber(payload.id_product)
--     id_user: tonumber(payload.id_user)
--     price: tonumber(payload.price)
--     purchase_date: os.date("%Y-%m-%d")
--     quantity: tonumber(payload.quantity)
--     delivery_type: tonumber(payload.delivery_type)
--     payment_type: tonumber(payload.payment_type)
--   }
--   {status: 201}

-- app:put "update_purchase", "/update-purchase/:id", ->
--   payload = @params
--   return {status: 404} unless payload
--   purchase_info = purchase:find tonumber(payload.id)
--   return {status: 404, json: {message: "Purchase not found."}} unless purchase_info
--   update_purchase = {
--     id: tonumber(payload.id)
--     id_product: tonumber(payload.id_product)
--     id_user: tonumber(payload.id_user)
--     price: tonumber(payload.price)
--     purchase_date: os.date("%Y-%m-%d")
--     quantity: tonumber(payload.quantity)
--     delivery_type: tonumber(payload.delivery_type)
--     payment_type: tonumber(payload.payment_type)
--   }
--   product:update update_purchase
--   {status: 204, json: update_purchase}

-- app:delete "delete_purchase", "/delete-purchase/:id", ->
--   purchase_info = purchase:find tonumber(@params.id)
--   return {status: 404, json: {message: "Purchase not found"}} unless purchase_info
--   purchase_info:delete()
--   {status: 204}

-- -- Product

-- app:get "get_products", "/get-product", ->
--   products = product:select()
--   return {status: 404, json: "No product types found."} unless products or #products > 0
--   {status: 200, json: products}

-- app:get "get_product", "/get-product/:id", ->
--   id = tonumber @params.id
--   return {json: {error: "Invalid ID"}, status: 400} unless id
--   product_info = product:find {id}
--   return {json: {error: "Product not found"}, status: 404} unless product_info
--   {json: product_info}

-- app:post "add_product", "/add-product", ->
--   payload = @params
--   return {status: 404} unless payload
--   product:create {
--     name: payload.name
--     category: tonumber(payload.category)
--     price: tonumber(payload.price)
--     created_date: os.date("%Y-%m-%d")
--     description: payload.description
--     available: not not payload.available
--   }
--   {status: 201}

-- app:put "update_product", "/update-product", ->
--   payload = @params
--   return {status: 404} unless payload
--   product_info = product:find tonumber(payload.id)
--   return {status: 404, json: {message: "Product not found."}} unless product_info
--   update_product = {
--     id: tonumber(payload.id)
--     name: payload.name
--     category: payload.category
--     price: tonumber(payload.price)
--     created_date: os.date("%Y-%m-%d")
--     description: payload.description
--     available: not not payload.available
--   }
--   product:update update_product
--   {status: 204, json: update_product}

-- app:delete "delete_product", "/delete-product/:id", ->
--   product_info = product:find tonumber(@params.id)
--   return {status: 404, json: {message: "Product not found"}} unless product_info
--   product_info:delete()
--   {status: 204}

-- -- User

-- app:get "get_users", "/get-user", ->
--   users = user:select()
--   return {status: 404, json: "No users found."} unless users or #users > 0
--   {status: 200, json: users}

-- app:get "get_user", "/get-user/:id", ->
--   id = tonumber @params.id
--   return {json: {error: "Invalid ID"}, status: 400} unless id
--   user_info = user:find {id}
--   return {json: {error: "User not found"}, status: 404} unless user_info
--   {json: user_info}

-- app:post "add_user", "/add-user", ->
--   payload = @params
--   return {status: 404} unless payload
--   user:create {
--     name: payload.name
--     surname: payload.surname
--     password: payload.password
--     address: payload.address
--     created_date: os.date("%Y-%m-%d")
--   }
--   {status: 201}

-- app:put "update_user", "/update-user/:id", ->
--   payload = @params
--   return {status: 404} unless payload
--   user_info = user:find tonumber(payload.id)
--   return {status: 404, json: {message: "Product not found."}} unless user_info
--   update_user = {
--     id: tonumber(payload.id)
--     name: payload.name
--     surname: payload.surname
--     password: payload.password
--     address: payload.address
--     created_date: os.date("%Y-%m-%d")
--   }
--   product:update update_user
--   {status: 204, json: update_user}

-- app:delete "delete_user", "/delete-user/:id", ->
--   user_info = user:find @params.id
--   return {status: 404, json: {message: "User not found"}} unless user_info
--   user_info:delete()
--   {status: 204}

-- app
