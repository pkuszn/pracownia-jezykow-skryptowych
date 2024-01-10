lapis = require "lapis"
import Model from require "lapis.db.model"
import respond_to from require "lapis.application"
import json_params from require "lapis.application"

class Category extends Model
class DeliveryType extends Model
class PaymentType extends Model
class Product extends Model
class Purchase extends Model
class User extends User

class extends lapis.Application
    "/hello": =>
        "Hello world"

    "/category": respond_to {
        GET: =>
            categories = Category\select!
            json: categories
    }

    "/category/:id[%d]": respond_to {
        GET: =>
            category = Category\find id: @params.id
            json: category
    }

