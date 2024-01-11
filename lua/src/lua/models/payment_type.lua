local Model = require("lapis.db.model").Model

local PaymentType = Model:extend("payment-type", {
    primary_key = "id",
    columns = {
        { "id", type = "serial" },
        { "name", type = "string" }
    }
})

return PaymentType