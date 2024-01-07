local UserController = {}

function UserController:index()
    local users = require("models.User"):select()
    if not users or #users == 0 then
        return { status = 404, json = "No users found."}
    end
    return { status = 200, json = users } 
end

function UserController.show(params)
    local user = require("models.User").find(params.id)
    if not user then
        return { status = 404, json = { message = "Cannot find specified user." } }
    end
end

function UserController:create(params)
    local userParams = self.params.user
    local user = require("models.User").create(userParams)
    return { status = 201, json = user }
end

function UserController:update(params)
    local userParams = self.params.user
    local user = require("models.User").find(params.id)
    if not user then
        return { status = 404, json = { message = "User not found." } }
    end
    user:update(userParams)
    return { status = 204, json = user }
end

function UserController:destroy(params)
    local user = require("models.User").find(params.id)
    if not user then
        return { status = 404, json = { message = "User not found" } }
    end
    user:delete()
    return { status = 204 }
end

return UserController
