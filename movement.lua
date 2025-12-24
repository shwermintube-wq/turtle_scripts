local facing = "north"

local m = {
    pos = {x=0,y=0,z=0},
    dir = 0
}

 function m.sync()
     local x,y,z = gps.locate()
     return {x=x,y=y,z=z, facing = facing}
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
     if facing == "north" then facing = "west"
     elseif facing == "east" then facing = "north"
     elseif facing == "south" then facing = "east"
     elseif facing == "west" then facing = "south"
     end
 end
 
 function m.right()
     turtle.turnRight()
     if facing == "north" then facing = "east"
     elseif facing == "east" then facing = "south"
     elseif facing == "south" then facing = "west"
     elseif facing == "west" then facing = "north"
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
     print(facing)
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
     

    while true do
        local pos = m.sync()
         
        if pos.x ~= entrance.x or pos.y ~= entrance.y or pos.z ~= entrance.z then
                
                
                
                -- Fixing the X value
        if phase == 1 then   
            if pos.x ~= entrance.x then 
                local dist = pos.x - entrance.x
                local steps = math.abs(dist)

                if facing == "north" and pos.x < entrance.x then -- Start of facing and distance
                    m.right()
                    for i=1, steps do
                        m.forward()
                    end
                    m.left()

                elseif facing == "west" and pos.x < entrance.x then
                    for i=1, steps do
                        m.forward()
                    end
                    m.left()

                elseif facing == "east" and pos.x < entrance.x then
                    m.turnAround()
                    for i=1, steps do
                        m.forward()
                    end
                    m.left()

                elseif facing == "south" and pos.x < entrance.x then
                    m.left()
                    for i=1, steps do
                        m.forward()
                    end
                    m.left()
                
                -- pos.x < entrance.x   ^

                elseif facing == "north" and pos.x > entrance.x then
                    m.left()
                    for i=1, steps do
                        m.forward()
                    end
                    m.right()
                
                elseif facing == "east" and pos.x > entrance.x then
                    for i=1, steps do
                        m.forward()
                    end
                    m.right()

                elseif facing == "south" and pos.x > entrance.x then
                    m.right()
                    for i=1, steps do
                        m.forward()
                    end
                    m.right()
                elseif facing == "west" and pos.x > entrance.x then
                    m.turnAround()
                    for i=1, steps do
                        m.forward()
                    end
                    m.right()

                -- pos.x > entrance.x
                else
                    
                end
            else
                phase = 2
                atX = true
            end -- End of fix facing and distance
        end -- End of phase 1
             os.sleep(0)

            -- Fixing z

           if phase == 2 then  
            print("Phase 2 check")
            local dist = pos.z - entrance.z
            local steps = math.abs(dist)
                if pos.z ~= entrance.z then
                    if pos.z < entrance.z then
                        m.turnAround()
                        for i=1, steps do
                            m.forward()
                        end
                    elseif pos.z > entrance.z then
                        for i=1, steps do
                            m.forward()
                        end
                    end
                end
            elseif pos.x ==entrance.x and pos.z == entrance.z then
                atZ = true
                phase = 3
                return
            end -- End of phase 2 

            if phase == 3 then
                print("Phase 3 check")
            end
        end -- Initial check
         
          
    end -- End of while true
 end -- End of Entrance Function

return m
