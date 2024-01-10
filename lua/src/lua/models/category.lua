local Model = require("lapis.db.model").Model

local category = Model.extend("category", {
    primary_key = "id",
    columns = {
        { "id", type = "serial" },
        { "name", type = "string" }
    }
})

return category