local Model = require("lapis.db.model").Model

local Product = Model.extend('product', {
    columns = {
        { "id", type = "serial" },
        { "name", type = "string" },
        { "category", type = "number" },
        { "price", type = "number" },
        { "created_date", type = "string" },
        { "description", type = "available" }
    }
})

return Product