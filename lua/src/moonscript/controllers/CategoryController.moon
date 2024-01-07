CategoryController = {}

CategoryController\index: =>
  categories = require "models.Product":select()
  if not categories or #categories == 0
    return {status: 404, json: "No categories found."}
  {status: 200, json: categories}

CategoryController\show: (params) ->
  category = require("models.Product").find(params.id)
  if not category
    return {status: 404, json: {message: "Specified category not found."}}

export CategoryController