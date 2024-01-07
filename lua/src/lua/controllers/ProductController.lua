local ProductController = {}

function ProductController:index()
    local products = require("models.Product"):select()
    if not products or #products == 0 then
        return { status = 404, json = "No products types found."}
    end
    return { status = 200, json = products } 
end

function ProductController.show(params)
    local product = require("models.Product").find(params.id)
    if not product then
        return { status = 404, json = { message = "Cannot find specified product." } }
    end
end

function ProductController:create()
    local productParams = self.params.product
    local product = require("models.Product").create(productParams)
    return { status = 201, json = product }
end

function ProductController:update(params)
    local productParams = self.params.product
    local product = require("models.Product").find(params.id)
    if not product then
        return { status = 404, json = { message = "Product not found." } }
    end
    product:update(productParams)
    return { status = 204, json = product }
end

function ProductController:destroy(params)
    local product = require("models.Product").find(params.id)
    if not product then
        return { status = 404, json = { message = "Product not found" } }
    end
    product:delete()
    return { status = 204 }
end

return ProductController
