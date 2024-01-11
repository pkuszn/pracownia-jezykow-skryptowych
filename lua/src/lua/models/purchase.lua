local Model = require("lapis.db.model").Model

local Purchase = Model:extend("purchase", {
    primary_key = "id",
    columns = {
        { "id", type = "serial" },
        { "id_product", type = "number" },
        { "id_user", type = "number" },
        { "price", type = "number" },
        { "quantity", type = "number" },
        { "purchase_date", type = "date" },
        { "delivery_type", type = "number" },
        { "payment_type", type = "number" }
    }
})

return Purchase