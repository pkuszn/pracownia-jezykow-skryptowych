UserController = {}

UserController\index: =>
  users = require "models.User":select()
  if not users or #users == 0
    return {status: 404, json: "No users found."}
  return {status: 200, json: users}

UserController\show: (params) ->
  user = require("models.User").find(params.id)
  if not user
    return {status: 404, json: {message: "Cannot find specified user."}}

UserController\create: =>
  userParams = @params.user
  user = require("models.User").create(userParams)
  {status: 201, json: user}

UserController\update: (params) =>
  userParams = @params.user
  user = require("models.User").find(params.id)
  if not user
    return {status: 404, json: {message: "User not found."}}
  user:update(userParams)
  {status: 204, json: user}

UserController\destroy: (params) =>
  user = require("models.User").find(params.id)
  if not user
    return {status: 404, json: {message: "User not found."}}
  user:delete()
  {status: 204}

export UserController