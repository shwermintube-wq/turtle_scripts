local BANK = require("lib.locations.bank")

local m = {
    pos = {x=0,y=0,z=0},
    dir = 0
}

 function m.sync()
     -- local pos = gps.locate()
     print(gps.locate())
    --m.saveTPos(pos.x,pos.z,pos.y)
    --return {x=pos.x,y=pos.y,z=pos.z, facing = m.loadFacing()} 
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

 function m.saveTPos(x,y,z)
    local file = fs.open("position.txt", "w")
    if file then
        file.writeLine(x)
        file.writeLine(y)
        file.writeLine(z)
        file.close()
    else
        print("Error: Unable to open position file.")
    end
 end

 function m.loadTPos()
    if fs.exists("position.txt") then
        local file = fs.open("position.txt", "r")
        local x = tonumber(file.readLine())
        local z = tonumber(file.readLine())
        local y = tonumber(file.readLine())
        file.close()
        return {x = x, y = y, z = z}
    else
        print("Position file not found. Returning default position,")
        return {x=0,y=0,z=0}
    end
 end

 function m.createTPos()
    if not fs.exists("position.txt") then
        local sP = gps.locate()
        local file = fs.open("position.txt", "w")

        file.writeLine(sP.x)
        file.writeLine(sP.z)
        file.writeLine(sP.y)
        file.close()
        print("Starting position file created")
    else
        print("File already exists")
    end
 end
 
 function m.left()
     local facing = m.loadFacing()

     if facing == "north" then
        turtle.turnLeft()
        m.saveFacing("west")
        return
     elseif facing == "south" then
        turtle.turnLeft()
        m.saveFacing("east")
     elseif facing == "east" then
        turtle.turnLeft()
        m.saveFacing("north")
     elseif facing == "west" then
        turtle.turnLeft()
        m.saveFacing("south")
     end
 end
 
 function m.right()
    local facing = m.loadFacing()

     if facing == "north" then
        turtle.turnRight()
        m.saveFacing("east")
     elseif facing == "south" then
        turtle.turnRight()
        m.saveFacing("west")
     elseif facing == "east" then
        turtle.turnRight()
        m.saveFacing("south")
     elseif facing == "west" then
        turtle.turnRight()
        m.saveFacing("north")
     end
 end

 function m.saveFacing(facing)
    local file = fs.open("facing.txt", "w")
    if file then
        file.write(facing)
        file.close()
    else
        print("Error: Can't open file.")
    end
 end

 function m.loadFacing()
    if fs.exists("facing.txt") then
        local file = fs.open("facing.txt", "r")
        local facing = file.readAll()
        file.close()
        return facing
    else
        return 
    end
 end

 function m.createFacing()
    if not fs.exists("facing.txt") then
        
        local file = fs.open("facing.txt", "w")
        file.write("north")
        file.close()
        print("Facing file created")
    else
        print("Facing file already exists")
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

 function m.select(slot)
    turtle.select(slot)
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
 
 function m.SelectedSlot()
     return turtle.getSelectedSlot()
 end
 
 function m.getFuelLevel()
     turtle.getFuelLevel()
 end

 function m.findX(x)
    local pos = m.loadTPos()
    local dist = pos.x - x
    local steps = math.abs(dist)


    if pos.x == x then
        return
    end

    while pos.x ~= x do
        pos = m.sync()

        if pos.x < x then
            if pos.facing == "north" then
                m.right()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "east" then
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "west" then
                m.turnAround()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "south" then
                m.left()
                for i=1, steps do
                    m.forward()
                end
                return
            end
        elseif pos.x > x then
            if pos.facing == "north" then
                m.left()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "east" then
                m.turnAround()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "west" then
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "south" then
                m.right()
                for i=1, steps do
                    m.forward()
                end
            end
        end
        os.sleep(0.2)
    end

 end

 function m.findY(y)
    local pos = m.loadTPos()
    local dist = pos.y - y
    local hops = math.abs(dist)

    if pos.y == y then
        return
    end

    while pos.y ~= y do
        pos = m.sync()

        if pos.y < y then
            for i=1, hops do
                m.up()
            end
            return
        elseif pos.y > y then
            for i=1, hops do
                m.down()
            end
            return
        end
    end

 end

 function m.findZ(z)
    local pos = m.loadTPos()
    local dist = pos.z - z
    local steps = math.abs(dist)

    if pos.z == z then
        return
    end

    while pos.z ~= z do
        pos = m.sync()

        if pos.z < z then
            if pos.facing == "north" then
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "east" then
                m.left()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "west" then
                m.right()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "south" then
                m.turnAround()
                for i=1, steps do
                    m.forward()
                end
                return
            end
        elseif pos.z > z then
            if pos.facing == "north" then
                m.turnAround()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "east" then
                m.right()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "west" then
                m.left()
                for i=1, steps do
                    m.forward()
                end
                return
            elseif pos.facing == "south" then
                for i=1, steps do
                    m.forward()
                end
            end
        end
        os.sleep(0.2)
    end

 end

function m.navigateTo(x,y,z)
    local pos = m.loadTPos()

    if pos.x == x and pos.y == y and pos.z == z then
        return
    end

    while pos.x ~= x or pos.y ~= y or pos.z ~= z do
        pos = m.sync()

        if pos.x ~= x then
            m.findX(x)
        elseif pos.z ~= z and pos.x == x then
            m.findZ(z)
        elseif pos.y ~= y and pos.x == x and pos.z == z then
            m.findY(y)
        end
    end
end

 function m.entrance()

    local entrance = {
        x = 15742,
        y = 254,
        z = 7052
    }
     
    local pos = m.loadTPos()

    if pos.x == entrance.x and pos.z == entrance.z and pos.y == entrance.y then
        return
    end

    while pos.x ~= entrance.x or pos.z ~= entrance.z or pos.y ~= entrance.y do
        pos = m.sync()

        if pos.x ~= entrance.x then
            m.findX(entrance.x)
            
        elseif pos.z ~= entrance.z and pos.x == entrance.x then
            m.findZ(entrance.z)
            
        elseif pos.y ~= entrance.y and pos.x == entrance.x and pos.z == entrance.z then
            m.findY(entrance.y)
        end
        os.sleep(0.2)
    end
end

function m.bank()

end

return m
