Model = require "lapis.db.model"

Category = Model.extend 'category',
  columns:
    { "id", type: "serial" }
    { "name", type: "string" }
    
export Category