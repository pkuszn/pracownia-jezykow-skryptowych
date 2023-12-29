local DeliveryTypeController = {}

function DeliveryTypeController:index()
    local deliveryTypes = require("models.DeliveryType"):select()
    if not deliveryTypes or #deliveryTypes == 0 then
        return { status = 404, json = "No delivery types found."}
    end
    return { status = 200, json = deliveryTypes } 
end

function DeliveryTypeController.show(params)
    local deliveryType = require("models.DeliveryType").find(params.id)
    if not deliveryType then
        return { status = 404, json = { message = "Specified delivery type not found." } }
    end
end

return DeliveryTypeController
