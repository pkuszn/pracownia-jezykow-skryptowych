local Model = require("lapis.db.model").Model

local Category = Model.extend("category", {
    columns = {
        { "id", type = "serial" },
        { "name", type = "string" }
    }
})

return Category