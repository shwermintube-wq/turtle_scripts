local m = {
    pos = {x=0,y=0,z=0},
    dir = 0
}

m.facing = "north"


 function m.sync()
     local x,y,z = gps.locate()
     return {x=x,y=y,z=z, facing = m.facing}
 end
 
 function m.up()
     turtle.up()
 end
 
 function m.down()
     turtle.down()
 end   
 function m.forward()
     turtle.forward()
 end
 
 function m.back()
     turtle.back()
 end
 
 function m.left()
     turtle.turnLeft()
     if m.facing == "north" then m.facing = "west"
     elseif m.facing == "east" then m.facing = "north"
     elseif m.facing == "south" then m.facing = "east"
     elseif m.facing == "west" then m.facing = "south"
     end
 end
 
 function m.right()
     turtle.turnRight()
     if m.facing == "north" then m.facing = "east"
     elseif m.facing == "east" then m.facing = "south"
     elseif m.facing == "south" then m.facing = "west"
     elseif m.facing == "west" then m.facing = "north"
     end
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


    print(location)

    local dist = pos.x - location
    local steps = math.abs(dist)

    if pos.x ~= location then
        while pos.x ~= location do
            if pos.x < location then
                if m.facing ~= "east" then
                    if m.facing == "north" then
                        m.right()
                    elseif m.facing == "south" then
                        m.left()
                    elseif m.facing == "west" then
                        m.turnAround()
                    end
                elseif m.facing == "east" then
                    print("facing east")
                    for i=1, steps do
                        m.forward()
                    end
                end

            elseif pos.x > location then
                if m.facing ~= "west" then
                    if m.facing == "north" then
                        m.left()
                    elseif m.facing == "south" then
                        m.right()
                    elseif m.facing == "east" then
                        m.turnAround()
                    end
                elseif m.facing == "west" then
                    print("facing west")
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
 
 function m.getItemDetail()
     local detail = turtle.getItemDetail()
     
     if detail then
         return detail.name,detail.count
     else
        return nil
     end    
 end
 
 function m.getSelectedSlot()
    local slot = turtle.getSelectedSlot()
    return slot
 end

 function m.select(slot)
    turtle.select(slot)
 end
 
 function m.getFuelLevel()
     turtle.getFuelLevel()
 end
 
 function m.getFacing()
     print(m.facing)
 end

 function m.faceNorth()
    if m.facing ~= "north" then
        if m.facing == "south" then
            m.turnAround()
        elseif m.facing == "east" then
            m.right()
        elseif m.facing == "west" then
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

    print(location)

    if pos.z ~= location then
        while pos.z ~= location do
            if pos.z < location then
                if m.facing ~= "south" then
                    if m.facing == "north" then
                        m.turnAround()
                    elseif m.facing == "east" then
                        m.right()
                    elseif m.facing == "west" then
                        m.left()
                    end
                elseif m.facing == "south" then
                    print("facing south")
                    for i=1, steps do
                        m.forward()
                    end
                end

            elseif pos.z > location then
                if m.facing ~= "north" then
                    if m.facing == "west" then
                        m.right()
                    elseif m.facing == "south" then
                        m.turnAround()
                    elseif m.facing == "east" then
                        m.left()
                    end
                elseif m.facing == "north" then
                    print("facing north")
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
    local isEmpty = false

    for i=1, slots do
        m.select(slot)
        if m.getItemDetail() then
            local isEmpty = true
            m.select(1)
            print(isEmpty)
            return isEmpty
        elseif i == 16 and m.getItemDetail() == nil then
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

    for i=1, slots do
        m.select(slot)
        if m.getItemDetail.name == "minecraft:coal" then
            if m.getItemDetail.name == "minecraft:coal" then
                amount = amount + m.getItemDetail.count

            end
            exists = true
        end
        slot = slot + 1
    end
    print(amount,exists)
    return amount,exists
end

return m
