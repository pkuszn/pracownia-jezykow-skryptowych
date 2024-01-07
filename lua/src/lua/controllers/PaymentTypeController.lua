local PaymentTypeController = {}

function PaymentTypeController:index()
    local paymentTypes = require("models.PaymentType"):select()
    if not paymentTypes or #paymentTypes == 0 then
        return { status = 404, json = "No payment types found."}
    end
    return { status = 200, json = paymentTypes } 
end

function PaymentTypeController.show(params)
    local paymentType = require("models.PaymentType").find(params.id)
    if not paymentType then
        return { status = 404, json = { message = "Cannot find specified payment type." } }
    end
end

return PaymentTypeController