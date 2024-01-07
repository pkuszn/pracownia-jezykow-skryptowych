local Model = require("lapis.db.model").Model

local PaymentType = Model.extend("payment-type", {
    columns = {
        { "id", type = "serial" },
        { "name", type = "string" }
    }
})

return PaymentType