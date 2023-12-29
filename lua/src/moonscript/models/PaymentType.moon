Model = require "lapis.db.model"

PaymentType = Model.extend 'payment-type',
  columns:
    { "id", type: "serial" }
    { "name", type: "string" }
    
export PaymentType