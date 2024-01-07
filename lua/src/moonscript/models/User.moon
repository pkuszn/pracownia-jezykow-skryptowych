local Model = require("lapis.db.model").Model

local User = Model.extend("user", {
    colunns = {
        { "id", type = "serial" },
        { "name", type = "string" },
        { "surname", type = "string" },
        { "password", type = "string" },
        { "address", type = "string" },
        { "created_date", type = "string" }
    }
})

return User