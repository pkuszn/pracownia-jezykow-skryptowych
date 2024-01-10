Model = require "lapis.db.model"

DeliveryType = Model.extend 'delivery-type',
  columns:
    { "id", type: "serial" }
    { "name", type: "string" }
    
export DeliveryType