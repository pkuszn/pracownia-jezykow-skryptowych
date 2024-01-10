ProductController = {}

ProductController\index: =>
  products = require "models.Product":select()
  if not products or #products == 0
    return {status: 404, json: "No product types found."}
  return {status: 200, json: products}

ProductController\show: (params) ->
  product = require("models.Product").find(params.id)
  if not product
    return {status: 404, json: {message: "Cannot find specified product."}}

ProductController\create: =>
  productParams = @params.product
  product = require("models.Product").create(productParams)
  {status: 201, json: product}

ProductController\update: (params) =>
  productParams = @params.product
  product = require("models.Product").find(params.id)
  if not product
    return {status: 404, json: {message: "Product not found."}}
  product:update(productParams)
  {status: 204, json: product}

ProductController\destroy: (params) =>
  product = require("models.Product").find(params.id)
  if not product
    return {status: 404, json: {message: "Product not found."}}
  product:delete()
  {status: 204}

export ProductController