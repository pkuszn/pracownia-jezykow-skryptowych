local CategoryController = {}

function CategoryController:index()
    local categories = require("models.Product"):select()
    if not categories or #categories == 0 then
        return { status = 404, json = "No categories found."}
    end
    return { status = 200, json = categories } 
end

function CategoryController.show(params)
    local category = require("models.Product").find(params.id)
    if not category then
        return { status = 404, json = { message = "Specified category not found." } }
    end
end

return CategoryController

