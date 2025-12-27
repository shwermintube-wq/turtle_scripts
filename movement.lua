local entrance = require(lib.locations.entrance)

local ENTRANCE = entrance.pos

local north = "north"
local east = "east"
local west = "west"
local south = "south"

local m = {
    pos = {x=0,y=0,z=0},
    dir = 0
}

 function m.sync()
     local x,y,z = gps.locate()
     m.savePos(x,y,z)

     local facing = m.loadFacing()
     return {x=x,y=y,z=z, facing = facing}
 end

 function m.saveFacing(facing)
    local file = fs.open("facing.txt", "w")
    if file then
        file.write(facing)
        file.close()
    end
 end

 function m.loadFacing()
    local file = fs.open("facing.txt", "w")
    if file then
        local facing = file.readAll()
        file.close()
        return facing
    end
 end
 
 function m.up()
     turtle.up()
     m.sync()
 end
 
 function m.down()
     turtle.down()
     m.sync()
 end   
 function m.forward()
     turtle.forward()
     m.sync()
 end
 
 function m.back()
     turtle.back()
     m.sync()
 end

 function m.loadPos()
    local exists = fs.exists("position.txt")

    if exists then
        local file = fs.open(position, "r")
        local content = file.readAll()
        local table = textutils.unserialise(content)
        file.close()

        local x = table.x
        local y = table.y
        local z = table.z

        return x,y,z

    end
 end

 function m.savePos(x,y,z)
    local table = {x=x,y=y,z=z}
    local serialized = textutils.serialise(table)
    local file = fs.open("position.txt", "w")
    file.write(serialized)
    file.close()

 end

 function m.initialize()
    local file1 = fs.exists("position.txt")
    local file2 = fs.exists("facing.txt")

    if not file1 then
        m.savePos()
    elseif not file2 then
        m.saveFacing("north")
    else
    end
 end
 
 function m.left()
     turtle.turnLeft()

     local facing = m.loadFacing()

     local file = fs.open("facing.txt", "w")
     if facing == north then m.saveFacing(west)
     elseif facing == east then m.saveFacing(north)
     elseif facing == south then m.saveFacing(east)
     elseif facing == west then m.saveFacing(south)
     end
     file.close()
 end
 
 function m.right()
     turtle.turnRight()

     local facing = m.loadFacing()

     local file = fs.open("facing.txt", "w")

     if facing == north then m.saveFacing(east)
     elseif facing == east then m.saveFacing(south)
     elseif facing == south then m.saveFacing(west)
     elseif facing == west then m.saveFacing(north)
     end
     file.close()
 end
 
 function m.detectUp()
     turtle.detectUp()
 end
 
 function m.detect()
     turtle.detect()
 end
  
 function m.detectDown()
     turtle.detectDown()
 end
 
 function m.digUp()
     turtle.digUp()
 end
 
 function m.digDown()
     turtle.digDown()
 end
 
 function m.drop()
     turtle.drop()
  end 
 
 function m.dropUp()
     turtle.dropUp()
 end
 
 function m.dropDown()
     turtle.dropDown()
 end
 
 function m.refuel()
     turtle.refuel()
 end
 
 function m.inspectUp()
     turtle.inspectUp()
 end
 
 function m.inspect()
     turtle.inspect()
 end
 
 function m.inspectDown()
     turtle.inspectDown()
 end
 
 function m.suck()
     turtle.suck()
 end
 
 function m.suckUp()
     turtle.suckUp()
 end
 
 function m.suckDown()
     turtle.suckDown()
 end
 
function m.findX(x)
    local pos = m.sync()

    local location = x

    local dist = pos.x - location
    local steps = math.abs(dist)

    if pos.x ~= location then
        while pos.x ~= location do
            if pos.x < location then
                if pos.facing ~= east then
                    if pos.facing == north then
                        m.right()
                    elseif pos.facing == south then
                        m.left()
                    elseif pos.facing == west then
                        m.turnAround()
                    end
                elseif pos.facing == east then
                    for i=1, steps do
                        m.forward()
                    end
                end

            elseif pos.x > location then
                if pos.facing ~= west then
                    if pos.facing == north then
                        m.left()
                    elseif pos.facing == south then
                        m.right()
                    elseif pos.facing == east then
                        m.turnAround()
                    end
                elseif pos.facing == west then
                    for i=1, steps do
                        m.forward()
                    end
                end
            end

            pos = m.sync()
            os.sleep(0.5)
        end
        
    else
    end
    
    
end

 function m.turnAround()
     for i=1,2 do m.left() end
 end
 
 function m.getSelectedSlot()
    local slot = turtle.getSelectedSlot()
    return slot
 end

 function m.select(slot)
    turtle.select(slot)
 end
 
 function m.checkFuelLevel()
     local minLevel = 20
     local enough = false
     local level = turtle.getFuelLevel()

     if level > minLevel then enough = true print(enough) return true elseif level <= minLevel then print(enough)  return false end
end
 
 function m.faceNorth()
    local pos = m.sync()
    if pos.facing ~= north then
        if pos.facing == south then
            m.turnAround()
        elseif pos.facing == east then
            m.right()
        elseif pos.facing == west then
            m.left()
        end
    else
    end
 end

 function m.findZ(z)
    local pos = m.sync()

    local dist = pos.z - z
    local steps = math.abs(dist)

    local location = z

    if pos.z ~= location then
        while pos.z ~= location do
            if pos.z < location then
                if pos.facing ~= south then
                    if pos.facing == north then
                        m.turnAround()
                    elseif pos.facing == east then
                        m.right()
                    elseif pos.facing == west then
                        m.left()
                    end
                elseif pos.facing == south then
                    for i=1, steps do
                        m.forward()
                    end
                end

            elseif pos.z > location then
                if pos.facing ~= north then
                    if m.facing == west then
                        m.right()
                    elseif pos.facing == south then
                        m.turnAround()
                    elseif pos.facing == east then
                        m.left()
                    end
                elseif pos.facing == north then
                    for i=1, steps do
                        m.forward()
                    end
                end
            end

            pos = m.sync()
            os.sleep(0.5)
        end
        
    else
    end

 end

  function m.findY(y)
    local pos = m.sync()

    local dist = pos.y - y
    local hops = math.abs(dist)
    local location = y

    print(location)

    if pos.y ~= y then   
        for i=1, hops do
            if pos.y < y then
                m.up()
            elseif pos.y > y then
                 m.down()
            end
        end
    end
  end

 function m.entrance()
    local phase = 1
      
    local atX = false
    local atZ = false
    local atY = false


    local entrance = {
        x = 15742,
        y = 254,
        z = 7052
    }
     
    local pos = m.sync()

    m.findX(entrance.x)
    m.findZ(entrance.z)
    m.findY(entrance.y)
    

end

function m.bank()
    local pos = m.sync()

    local entrance = {
        x = 15742,
        y = 254,
        z = 7052
    }

    local bankCoords = {
        x = 15741,
        y = 253,
        z = 7060

    }

    if pos.x ~= bankCoords.x or pos.y ~= bankCoords.y or pos.z ~= bankCoords.z then
        
        local slots = 16
        local selectedSlot = 1
        m.findX(bankCoords.x)
        m.findZ(bankCoords.z)
        m.findY(bankCoords.y)

        for i=1, 16 do
            turtle.select(selectedSlot)
            turtle.drop()
            selectedSlot = selectedSlot + 1
        end

        m.turnAround()
        return "Banked"

    else
        local slots = 16
        local selectedSlot = 1

        for i=1, 16 do
            turtle.select(selectedSlot)
            turtle.drop()
            selectedSlot = selectedSlot + 1
        end

        m.turnAround()
        return "Banked"

    end
end

function m.checkEmptyInventory()
    local slots = 16
    local slot = 1
    local isEmpty = true
    local item = turtle.getItemDetail()

    for i=1, slots do
        m.select(slot)
        if item then
            local isEmpty = false
            m.select(1)
            print(isEmpty)
            return isEmpty
        elseif i == 16 and item == nil then
            m.select(1)
            print(isEmpty)
            return isEmpty
        else
        end

        slot = slot + 1

    end
end

function m.checkIfFuel()
    local slots = 16
    local slot = 1
    local amount = 0
    local exists = false
    local item = turtle.getItemDetail()

    for i=1, slots do
        m.select(slot)
        if item.name == "minecraft:coal" then
            amount = amount + item.count
            exists = true
            print(amount,exists)
        end
        slot = slot + 1
    end
    
    return amount,exists
end

--[[ function m.mining()
    local entranceY = entrance.
    while true do
        m.sync()
        os.sleep(0.5)
    end
end ]]

return m
