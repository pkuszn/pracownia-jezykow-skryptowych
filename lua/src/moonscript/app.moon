lapis = require("lapis")
import Model from require "lapis.db.model"
csrf = require "lapis.csrf"
capture_errors = require("lapis.application").capture_errors
import respond_to from require "lapis.application"
import json_params from require "lapis.application"


class Category extends Model
class PaymentType extends Model
class DeliveryType extends Model
class Product extends Model
class Purchase extends Model
class User extends Model

class App extends lapis.Application
    "/hello": respond_to {
        GET: =>
            { json: "hello world"}
    }

    "/get-categories": respond_to {
        GET: =>
            @user = Category\select!
            @write status: 404, "Not Found" unless @user
            {json: @user }
    }

    "/get-category/:id": respond_to {    
        GET: =>
            @user = Category\find id: @params.id
            @write status: 404, "Not Found" unless @user
            { json: @user }
    }

    "/get-payment-types": respond_to {
        GET: =>
            @payment_type = PaymentType\select!
            @write status: 404, "Not Found" unless @payment_type
            {json: @payment_type }
    }

    "/get-payment-type/:id": respond_to {
        GET: => 
            @payment_type = PaymentType\find id: @params.id
            @write status: 404, "Not Found" unless @payment_type
            { json: @payment_type }
    }

    "/get-delivery-types": respond_to {
        GET: => 
            @delivery_type = DeliveryType\select!
            @write status: 404, "Not Found" unless @delivery_type
            { json: @delivery_type }
    }

    "/get-delivery-type/:id": respond_to {
        GET: => 
            @delivery_type = DeliveryType\find id: @params.id
            @write status: 404, "Not Found" unless @delivery_type
            { json: @delivery_type }
    }

    "/products": respond_to {
        GET: => 
            @product = Product\select!
            @write status: 404, "Not Found" unless @product
            { json: @product }
        POST: json_params =>
            @product = Product\create
                name: @params.name 
                category: tonumber(@params.category) 
                price: tonumber(@params.price) 
                created_date: os.date("%Y-%m-%d") 
                description: @params.description 
                available: not not @params.available
            { json: @product }
    }

    "/product": respond_to {
        PUT: json_params =>
            @product = Product\find id: @params.id
            @write status: 404, "Not Found" unless @product
            @product\update @params
            { json: @product }
    }

    "/product/:id": respond_to {
        GET: => 
            @product = Product\find id: @params.id
            @write status: 404, "Not Found" unless @product
            { json: @product }
        DELETE: =>
            @product = Product\find id: @params.id
            @write status: 404, "Not Found" unless @product
            @product\delete!
            { json: "Item deleted" }
    }

    "/purchases": respond_to {
        GET: => 
            @purchase = Purchase\select!
            @write status: 404, "Not Found" unless @purchase
            { json: @purchase }
        POST: json_params =>
            @purchase = Purchase\create 
                id_product: tonumber(@params.id_product) 
                id_user: tonumber(@params.id_user) 
                price: tonumber(@params.price) 
                quantity: tonumber(@params.quantity)
                purchase_date: os.date("%Y-%m-%d")
                delivery_type: tonumber(@params.delivery_type)
                payment_type: tonumber(@params.payment_type)
            { json: @purchase }
    }

    "/purchase": respond_to {
        PUT: json_params =>
            @purchase = Purchase\find id: @params.id
            @write status: 404, "Not Found" unless @purchase
            @purchase\update @params 
            { json: @purchase }
    }

    "/purchase/:id": respond_to {
        GET: => 
            @purchase = Purchase\find id: @params.id
            @write status: 404, "Not Found" unless @purchase
            { json: @purchase }

        DELETE: =>
            @purchase = Purchase\find id: @params.id
            @write status: 404, "Not Found" unless @purchase
            @purchase\delete!
            { json: "Item deleted" } 
    }

    "/users": respond_to {
        GET: => 
            @user = User\select!
            @write status: 404, "Not Found" unless @user
            { json: @user }
        POST: json_params =>
            @user = User\create 
                name: @params.name 
                surname: @params.surname
                password: @params.password
                address: @params.address
                created_date: os.date("%Y-%m-%d") 
            { json: @user }
    }

    "/user": respond_to {
        PUT: =>
            @user = User\find id: @params.id
            @write status: 404, "Not Found" unless @user
            @user\update @params
            { json: @user }
    }
    
    "/user/:id": respond_to {
        GET: => 
            @user = User\find id: @params.id
            @write status: 404, "Not Found" unless @user
            { json: @user }

        DELETE: =>
            @user = User\find id: @params.id
            @write status: 404, "Not Found" unless @user
            @user\delete!
            { json: "Item deleted" } 
    }