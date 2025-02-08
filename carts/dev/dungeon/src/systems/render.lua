
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

-- 0 = right
-- 0.125 = rdown
-- 0.25 = down
-- 0.375 = ldown
-- 0.5 = left
-- 0.625 = lup
-- 0.75 = up
-- 0.875 = rup
function angleToFlip(angle)
    if angle == 0 then
      return false, false
    elseif angle == 0.125 then
      return false, true
    elseif angle == 0.25 then
      return false, false
    elseif angle == 0.375 then
      return true, true
    elseif angle == 0.5 then
      return true, false
    elseif angle == 0.625 then
      return true, false
    elseif angle == 0.75 then
      return false, true
    elseif angle == 0.875 then
      return false, false
    end
  
    return false, false
end

  
renderSystem = world.system({ Position, Renderable, Size }, function(entity)
    -- log(entity[Position].x,true)
    local flipx, flipy = nil, nil
    local sprite = entity[Renderable].sprite
    if entity[Direction] then
      -- log(entity[Direction].simple)
      flipx, flipy = angleToFlip(entity[Direction].angle)
      dirSprite = entity[Direction].sprite[entity[Direction].angle]
    --   log(dirSprite)
    --   log(entity[Direction].angle,true)
      if dirSprite then
        sprite = dirSprite
      end
    end
  
    flipx = entity[Renderable].flipXEnabled and flipx or false
    flipy = entity[Renderable].flipYEnabled and flipy or false
    
    spr(sprite, entity[Position].x, entity[Position].y, ceil(entity[Size].w/8), ceil(entity[Size].h/8), flipx, flipy)
  end)
  