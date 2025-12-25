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
                if m.sync().facing ~= "east" then
                    if m.sync().facing == "north" then
                        m.right()
                    elseif m.sync().facing == "south" then
                        m.left()
                    elseif m.sync().facing == "west" then
                        m.turnAround()
                    end
                elseif m.sync().facing == "east" then
                    print("facing east")
                    for i=1, steps do
                        m.forward()
                    end
                end

            elseif pos.x > location then
                if m.sync().facing ~= "west" then
                    if m.sync().facing == "north" then
                        m.left()
                    elseif m.sync().facing == "south" then
                        m.right()
                    elseif m.sync().facing == "east" then
                        m.turnAround()
                    end
                elseif m.sync().facing == "west" then
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

    local location = z
    local facing = m.sync().facing

    if pos.z ~= location then
        if pos.z < location then
            if facing ~= "south" then
                if facing == "west" then
                    m.left()
                elseif facing == "east" then
                    m.right()
                elseif facing == "north" then
                    m.turnAround()
                end
            else
                for i=1, steps do
                m.forward()
                end
            end

        elseif pos.z > location then
            if facing ~= "north" then
                if facing == "east" then
                    m.left()
                elseif facing == "west" then
                    m.right()
                elseif facing == "south" then
                    m.turnAround()
                end
            else
                for i=1, steps do
                    m.forward()
                end
            end
        end
    else

    end

 end

  function m.findY(y)
    local pos = m.sync()

    local dist = pos.y - y
    local steps = math.abs(dist)
    
    local facing = m.sync().facing

    if pos.y ~= y then
        if facing ~= "north" then
            if facing == "west" then
                m.right()
            elseif facing == "east" then
                m.left()
            elseif facing == "south" then
                m.turnAround()
            end
        else
            for i=1, steps do
                if pos.y < y then
                    m.up()
                elseif pos.y > y then
                    m.down()
                end
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

    m.findX(entrance.x)
    

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
        
        m.findX(bankCoords.x)
        m.findZ(bankCoords.z)
        m.findY(bankCoords.y)

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
