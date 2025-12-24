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
        if pos.x < location then
            m.turnAround()
            for i=1, steps do
                m.forward()
            end
        elseif pos.x > location then
            for i=1, steps do
                m.forward()
            end
        end
    else
    end
end

 function m.turnAround()
     for i =1,2 do m.left() end
 end
 
 function m.getItemDetail()
     local detail = turtle.getItemDetail()
     
     if detail then
         if detail.name and detail.count then
             print(detail.name)
             print(detail.count)
         end
     end    
 end
 
 function m.getSelectedSlot()
     local slot = turtle.getSelectedSlot()
     print(slot)
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
    if pos.z ~= z then
        if pos.z < z then
             m.turnAround()
            for i=1, steps do
                m.forward()
            end
        elseif pos.z > z then
            for i=1, steps do
                 m.forward()
            end
        end
    else
    end

 end

  function m.findY(y)
    local pos = m.sync()

    local dist = pos.y - y
    local steps = math.abs(dist)
    if pos.y ~= y then
        if pos.y < y then
            for i=1, steps do
                m.up()
            end
        elseif pos.y > y then
            for i=1, steps do
                 m.down()
            end
        end
    else
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
    local atEntrance = false

    while atEntrance == false do
        if pos.x ~= entrance.x then
        m.findX(entrance.x)
        end
        if pos.z ~= entrance.z then
            m.findZ(entrance.z)
        end
        if pos.y ~= entrance.y then
                m.findY(entrance.y)
        end
        if pos.x == entrance.x and pos.y == entrance.y and pos.z == entrance.z then
            atEntrance = true
        end
    end

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
        local x = bankCoords.x
        local y = bankCoords.y
        local z = bankCoords.z
        

        m.findX(x)
        m.findZ(z)
        m.findY(y)

    else
        local slots = 16
        local selectedSlot = 1

        for i=1, 16 do
            turtle.select(selectedSlot)
            turtle.drop()
            selectedSlot = selectedSlot + 1
        end
        turtle.select(1)
        selectedSlot = 1
        m.turnAround()
        return "Banked"

    end
end

return m
