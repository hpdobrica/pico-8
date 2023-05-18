
function simpleDirToFlip(dir)
    if dir == "right" then
      return false, false
    elseif dir == "rup" then
      return false, false
    elseif dir == "rdown" then
      return false, true
    elseif dir == "left" then
      return true, false
    elseif dir == "lup" then
      return true, false
    elseif dir == "ldown" then
      return true, true
    elseif dir == "up" then
        return false, false
    elseif dir == "down" then
        return false, true 
    end
  
    return false, false
  end
  
renderSystem = world.system({ Position, Renderable, Size }, function(entity)
    local flipx, flipy = nil, nil
    local sprite = entity[Renderable].sprite
    if entity[Direction] then
      -- log(entity[Direction].simple)
      flipx, flipy = simpleDirToFlip(entity[Direction].simple)
      dirSprite = entity[Direction].sprite[entity[Direction].simple]
      if dirSprite then
        sprite = dirSprite
      end
    end
  
    flipx = entity[Renderable].flipXEnabled and flipx or false
    flipy = entity[Renderable].flipYEnabled and flipy or false
    
    spr(sprite, entity[Position].x, entity[Position].y, ceil(entity[Size].w/8), ceil(entity[Size].h/8), flipx, flipy)
  end)
  