local drawableLine = require("structs.drawable_line")
local drawableSprite = require("structs.drawable_sprite")
local utils = require("utils")
local communalHelper = require("mods").requireFromPlugin("libraries.communal_helper")

local segmentDreamBooster = {}

segmentDreamBooster.name = "CommunalHelper/DreamBooster"
segmentDreamBooster.depth = -11000
segmentDreamBooster.nodeLimits = {1, 1}
segmentDreamBooster.nodeVisibility = "always"
segmentDreamBooster.fieldInformation = {
    pathStyle = {
        options = communalHelper.dreamBoosterPathStyles,
        editable = false
    }
}

segmentDreamBooster.placements = {
    {
        name = "normal",
        data = {
            hidePath = false,
            pathStyle = "Arrow",
            proximityPath = true
        }
    },
    {
        name = "hidden_path",
        data = {
            hidePath = true,
            pathStyle = "Arrow",
            proximityPath = true
        }
    }
}

local texture = "objects/CommunalHelper/boosters/dreamBooster/idle00"
local hiddenPathColor = {1.0, 1.0, 1.0, 0.25}

function segmentDreamBooster.sprite(room, entity)
    local x, y = entity.x or 0, entity.y or 0
    local nodes = entity.nodes or {{x = 0, y = 0}}
    local nx, ny = nodes[1].x, nodes[1].y

    return {
        drawableLine.fromPoints({x, y, nx, ny}, entity.hidePath and hiddenPathColor or {1, 1, 1}),
        drawableSprite.fromTexture(texture, entity)
    }
end

segmentDreamBooster.nodeTexture = texture
segmentDreamBooster.nodeColor = {1, 1, 1, 0.25}

function segmentDreamBooster.selection(room, entity)
    local rect = utils.rectangle(entity.x - 9, entity.y - 9, 18, 18)

    local nodes = entity.nodes or {{x = 0, y = 0}}
    local nx, ny = nodes[1].x, nodes[1].y
    local nodeRect = utils.rectangle(nx - 9, ny - 9, 18, 18)

    return rect, {nodeRect}
end

return segmentDreamBooster
