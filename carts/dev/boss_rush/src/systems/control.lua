

controlSystem = world.system({ Controllable, Velocity }, function(entity, dt)

    local setDirection = false
    local initialDirection = nil
    if entity[Direction] then
      setDirection = true
      initialDirection = entity[Direction].simple
    end

    local speed = entity[Velocity].speed * dt
    if btn(0) then -- left
      entity[Velocity].x = -speed
      if setDirection then
        entity[Direction].simple = "left"
      end
    elseif btn(1) then -- right
      entity[Velocity].x = speed
      if setDirection then
        entity[Direction].simple = "right"
      end
    else
      entity[Velocity].x = 0
    end
    
    
    if btn(2) then -- up
    --   entity[Velocity].y = -speed
        if setDirection then
          log(entity[Direction].simple)
          local prefix = sub(entity[Direction].simple,1, 1)
          entity[Direction].simple = prefix.."up"
        end
    elseif btn(3) then -- down
    --   entity[Velocity].y = speed
        if setDirection then
          local prefix = sub(entity[Direction].simple,1, 1)
          entity[Direction].simple = prefix.."down"
        end
    else
      entity[Velocity].y = 0
      if setDirection then
        local dir = entity[Direction].simple
        if dir == "lup" or dir == "ldown" then
          entity[Direction].simple = "left"
        elseif dir == "rup" or dir == "rdown" then
          entity[Direction].simple = "right"
        end
      end
    end
  
    if btnp(4) then -- O
        entity[Velocity].y = -speed * 4 -- jump
    end

    if btnp(5) then -- X
        entity = entity + Action({
            action = Attack({ damage=1, range=1, angle=0 }),
            delay = 0.1,
            cooldown = 0.5
        })
        -- Action = world.component({ action=nil, delay=0, cooldown=0 })
        -- SwordAttack = world.component({ damage=0, range=0, angle=0 })
    --   entity[Velocity].y = speed * 3
    end
  end)


