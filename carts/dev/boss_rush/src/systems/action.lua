
actionSystem = world.system({ Action }, function(entity, dt)
    if entity[Action].delay > 0 then
        entity[Action].delay = entity[Action].delay - 1 * dt
        return
    end
    if entity[entity.Action.action] ~= nil then
        entity = entity + entity[Action].action
        return
    end
    if entity[Action].cooldown > 0 then
        entity[Action].cooldown = entity[Action].cooldown - 1 * dt
        return
    end

    entity = entity - Action
    
  end)

attackSystem = world.system({ Position, Attack }, function(entity, dt)
    
    
  end)