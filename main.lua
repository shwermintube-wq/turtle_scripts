local home = require("lib.locations.home")
local move = require("lib.movement")
local safety = require("lib.safety")
local net = require("lib.net")
local entrance = require("lib.locations.entrance")
local bank = require("lib.locations.bank")

local BANK = bank.pos
local ENTRANCE = entrance.pos
local HOME = home.load()

move.sync()

local function handleCommand(sender, msg)
    local args = {}
    print("Debug", msg)
    for word in string.gmatch(msg, "%S+") do
        table.insert(args, word)
    end

    local msg = args[1]

    if msg == "up" then
        local dist = tonumber(args[2]) or 1
        for i=1, dist do
            move.up(1)
        end
        return "Moved up"..dist

    elseif msg == "down" then
        local dist = tonumber(args[2]) or 1
        for i=1, dist do
            move.down(1)
        end
        return "Moved down"..dist

     elseif msg == "forward" then
        local dist = tonumber(args[2] ) or 1
        for i=1, dist do
            move.forward(1)
        end
        return "Moved forward"..dist
        
         elseif msg == "back" then
        local dist = tonumber(args[2]) or 1
        for i=1, dist do
            move.back(1)
        end
        return "Moved back"..dist

    
    elseif msg == "left" then
        local amount = tonumber(args[2]) or 1
        for i=1, amount do
            move.left()
        end
        return "Turned left"..amount

    elseif msg == "right" then
        local amount = tonumber(args[2]) or 1
        for i=1, amount do
            move.right()
        end
        return "Turned right"..amount

    elseif msg == "detectUp" then
        move.dUp()
    elseif msg == "detectDown" then
        move.dDown()

    elseif msg == "diDown" then
        move.digDown()
    elseif msg == "diUp" then
        move.digUp()

    elseif msg == "drop" then
        move.drop()
        return "Dropped"
    elseif msg == "dropUp" then
        move.dropUp()
        return "Dropped"
    elseif msg == "dropDown" then
        move.dropDown()
        return "Dropped"

    elseif msg == "entrance" then
        move.entrance()

    elseif msg == "bank" then
        local pos = move.sync()
        local atBank = false
        local banked = false

        local n = 16

        local slot = 1

        move.findX(BANK.x)
        move.findZ(BANK.z)
        move.findY(BANK.y)

        if pos.x == BANK.x and pos.y == BANK.y and pos.z == BANK.z then atBank = true end



        if atBank then

            if banked ~= true then 
                if atBank then
                    for i=1, n do
                        if i == n then
                            move.select(slot)
                            move.drop()
                            move.left(2)
                        end
                        move.select(slot)
                        move.drop()
                        slot = slot + 1
                    end

                    banked = true
                end
             end
            
        end


    end
end -- End of handler

net.listen(handleCommand)