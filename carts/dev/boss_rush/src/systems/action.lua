
actionSystem = world.system({ Action }, function(entity, dt)
    log("action system")
    local actionComp = entity[Action]
    if actionComp.action == nil then
        return
    end
    if actionComp.state == "init" then
        actionComp.state = "delay"
        return
    end
    if actionComp.delay > 0 then
        actionComp.delay = entity[Action].delay - 1 * dt
        return
    end

    if actionComp.state == "delay" then
        actionComp.state = "act"
        return
    end

    if actionComp.state == "act" then
        entity = entity + actionComp.action
        log(entity[actionComp.action._comp_factory].damage)
        actionComp.state = "cooldown"
        
        return
    end
    log("added action: " .. entity[Action].action.damage)
    if entity[Action].cooldown > 0 then
        entity[Action].cooldown = entity[Action].cooldown - 1 * dt
        
        return
    end
    log("removing action: " .. actionComp.action.damage)

    entity = entity - Action
    
  end)

attackEnt = nil

attackSystem = world.system({ Position, Attack }, function(entity, dt)
        log("attack create")

    angle = entity[Direction].angle
    dx = cos(angle) * 4
    dy = -sin(angle) * 4
    log(dx .. " " .. dy,true)
    attackEnt = world.entity({},
        Position({ x=entity[Position].x+dx, y=entity[Position].y + dy }),
        Size({w=8,h=8, ox=0, oy=0}),
        Velocity({ x=0, y=0, speed=0 }),
        Renderable({ sprite=49 }),
        Lifetime({ duration=5 })
    )
    entity = entity - Attack

    
    
    
  end)

lifetimeSystem = world.system({ Lifetime }, function(entity, dt)
    log("lifetime")
    if entity[Lifetime].duration > 0 then
        entity[Lifetime].duration = entity[Lifetime].duration - 1 * dt
        return
    end
    log("lifetime delete")
    world.remove(entity)
  end)