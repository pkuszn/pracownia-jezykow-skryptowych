local Model = require("lapis.db.model").Model

local Product = Model:extend('product', {
    primary_key = "id",
    columns = {
        { "id", type = "serial" },
        { "name", type = "string" },
        { "category", type = "number" },
        { "price", type = "number" },
        { "created_date", type = "date" },
        { "description", type = "string" },
        { "available", type = "boolean" }
    }
})

return Product