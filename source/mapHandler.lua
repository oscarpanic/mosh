local pd <const> = playdate
local gfx <const> = playdate.graphics

class('MapHandler')

local CROWD_SCALE <const> = 2
local MAP <const> = {
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {'c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c'},
    {'c','c','c','c','c','c','c','c','c','c','','','','','','','c','c','c','c','c','c','c','c','c','c'},
    {'c','c','c','c','c','c','c','','','','','','','','','','','','','c','c','c','c','c','c','c'},
    {'c','c','c','c','c','c','','','','','','','','','','','','','','','c','c','c','c','c','c'},
    {'c','c','c','c','c','','','','','','','','','','','','','','','','','c','c','c','c','c'},
    {'c','c','c','c','','','','','','','','','','','','','','','','','','','c','c','c','c'},
    {'c','c','c','c','c','','','','','','','','','','','','','','','','','c','c','c','c','c'},
    {'c','c','c','c','c','c','','','','','','','','','','','','','','','c','c','c','c','c','c'},
    {'c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c','c'},
}

function mapInit()
    for i, row in ipairs(MAP) do
        for j,symbol in ipairs(row) do
            if symbol == 'c' then
                local tile = CrowdTile((j-1)*16, (i-1)*16, CROWD_SCALE)
            end
        end
    end
end