DeliveryTypeController = {}

DeliveryTypeController\index: =>
  deliveryTypes = require "models.DeliveryType":select()
  if not deliveryTypes or #deliveryTypes == 0
    return {status: 404, json: "No delivery types found."}
  {status: 200, json: deliveryTypes}

DeliveryTypeController\show: (params) ->
  deliveryType = require("models.DeliveryType").find(params.id)
  if not deliveryType
    return {status: 404, json: {message: "Specified delivery type not found."}}

export DeliveryTypeController