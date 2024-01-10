Model = require "lapis.db.model"

Product = Model.extend 'product',
  columns:
    { "id", type: "serial" }
    { "name", type: "string" }
    { "category", type: "number" }
    { "price", type: "number" }
    { "created_date", type: "string" }
    { "description", type: "available" }

export Product