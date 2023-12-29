PaymentTypeController = {}

PaymentTypeController\index: =>
  paymentTypes = require "models.PaymentType":select()
  if not paymentTypes or #paymentTypes == 0
    return {status: 404, json: "No payment types found."}
  {status: 200, json: paymentTypes}

PaymentTypeController\show: (params) ->
  paymentType = require("models.PaymentType").find(params.id)
  if not paymentType
    return {status: 404, json: {message: "Cannot find specified payment type."}}

export PaymentTypeController