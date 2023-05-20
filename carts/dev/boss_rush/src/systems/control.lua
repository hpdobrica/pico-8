
local tmpX = {}

controlSystem = world.system({ Controllable, Velocity }, function(entity, dt)

    local setDirection = false
    local initialAngle = 0

    if tmpX[entity] == nil then
      tmpX[entity] = entity[Velocity].x
    end
    if entity[Direction] then
      setDirection = true
    end

    local speed = entity[Velocity].speed * dt
    if btn(0) then -- left
      entity[Velocity].x = -speed
      tmpX[entity] = -speed
    elseif btn(1) then -- right
      entity[Velocity].x = speed
      tmpX[entity] = speed
    else
      entity[Velocity].x = 0
    end
    
    local fakeVelocityY = 0
    if btn(2) then -- up
      fakeVelocityY = -speed
    elseif btn(3) then -- down
      fakeVelocityY = speed
    else
      fakeVelocityY = 0

    end
    
    if setDirection then
      if tmpX[entity] == 0 and fakeVelocityY == 0 then
        entity[Direction].angle = 0
      else
        entity[Direction].angle = atan2(tmpX[entity], -fakeVelocityY)
      end
    end
  
    if btnp(4) then -- O
        entity[Velocity].y = -speed * 4 -- jump
    end

    if btnp(5) then -- X
        entity = entity + Action({
            action = Attack({ damage=1, range=1, angle=entity[Direction].angle, duration=10 }),
            delay = 0.5,
            cooldown = 5
        })
        -- Action = world.component({ action=nil, delay=0, cooldown=0 })
        -- SwordAttack = world.component({ damage=0, range=0, angle=0 })
    --   entity[Velocity].y = speed * 3
    end
  end)


