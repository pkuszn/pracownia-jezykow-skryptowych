local PurchaseController = {}

function PurchaseController:index()
    local purchases = require("models.Purchase"):select()
    if not purchases or #purchases == 0 then
        return { status = 404, json = "No purchases found."}
    end
    return { status = 200, json = purchases } 
end

function PurchaseController.show(params)
    local purchase = require("models.Purchase").find(params.id)
    if not purchase then
        return { status = 404, json = { message = "Cannot find specified purchase." } }
    end
end

function PurchaseController:create()
    local purchaseParams = self.params.purchase
    local purchase = require("models.Purchase").create(purchaseParams)
    return { status = 201, json = purchase }
end

function PurchaseController:update(params)
    local purchaseParams = self.params.purchase
    local purchase = require("models.Purchase").find(params.id)
    if not purchase then
        return { status = 404, json = { message = "Purchase not found." } }
    end
    purchase:update(purchaseParams)
    return { status = 204, json = purchase }
end

function PurchaseController:destroy(params)
    local purchase = require("models.Purchase").find(params.id)
    if not purchase then
        return { status = 404, json = { message = "Purchase not found" } }
    end
    purchase:delete()
    return { status = 204 }
end

return PurchaseController
