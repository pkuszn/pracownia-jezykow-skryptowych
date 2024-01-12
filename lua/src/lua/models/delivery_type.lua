local Model = require("lapis.db.model").Model

local DeliveryType = Model:extend("delivery-type", {
    primary_key = "id",
    columns = {
        { "id", type = "serial" },
        { "name", type = "string" }
    }
})

return DeliveryType