PurchaseController = {}

PurchaseController\index: =>
  purchases = require "models.Purchase":select()
  if not purchases or #purchases == 0
    return {status: 404, json: "No purchases found."}
  return {status: 200, json: purchases}

PurchaseController\show: (params) ->
  purchase = require("models.Purchase").find(params.id)
  if not purchase
    return {status: 404, json: {message: "Cannot find specified purchase."}}

PurchaseController\create: =>
  purchaseParams = @params.purchase
  purchase = require("models.Purchase").create(purchaseParams)
  {status: 201, json: purchase}

PurchaseController\update: (params) =>
  purchaseParams = @params.purchase
  purchase = require("models.Purchase").find(params.id)
  if not purchase
    return {status: 404, json: {message: "Purchase not found."}}
  purchase:update(purchaseParams)
  {status: 204, json: purchase}

PurchaseController\destroy: (params) =>
  purchase = require("models.Purchase").find(params.id)
  if not purchase
    return {status: 404, json: {message: "Purchase not found."}}
  purchase:delete()
  {status: 204}

export PurchaseController