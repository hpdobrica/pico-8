collideSystem = world.system({Position, Velocity, Size, Collidable}, function(entity, dt)
  local x = entity[Position].x
  local y = entity[Position].y
  local w = entity[Size].w
  local h = entity[Size].h

  -- if flag 1 based on velocity then wall
  if entity[Velocity].x > 0 then
    if fget(mget((x + w) / 8, y / 8), 1) then
      entity[Velocity].x = 0
    end
  elseif entity[Velocity].x < 0 then
    if fget(mget(x / 8, y / 8), 1) then
      entity[Velocity].x = 0
    end
  end

  if entity[Velocity].y > 0 then
    if fget(mget(x / 8, (y + h) / 8), 1) then
      entity[Velocity].y = 0
    end
  elseif entity[Velocity].y < 0 then
    if fget(mget(x / 8, y / 8), 1) then
      entity[Velocity].y = 0
    end
  end

end)


function checkCollisions(entity, dir, flags)
  local x = entity[Position].x
  local y = entity[Position].y
  local w = entity[Size].w
  local h = entity[Size].h
  local ox = entity[Size].ox
  local oy = entity[Size].oy
  local ix = x + ox + dir[1]
  local iy = y + oy + dir[2]

  for jx = ix, ix + w - 1 do
    for jy = iy, iy + h - 1 do
      local tx = flr(jx / 8)
      local ty = flr(jy / 8)
      for _, v in pairs(flags) do
        if fget(mget(tx, ty), v) then
          local offsetY = 0
          local nearestTy = ty * 8
          if dir[2] > 0 then
            offsetY = nearestTy - (y + oy + h)-1
          end
          if dir[2] < 0 then
            offsetY = nearestTy - (y + oy)+8
          end

          local offsetX = 0
          local nearestTx = tx * 8
          if dir[1] > 0 then
            offsetX = nearestTx - (x + ox + w)-1
          end
          if dir[1] < 0 then
            offsetX = nearestTx - (x + ox)+8
          end
          return true, {
            x = offsetX,
            y = offsetY
          }
        end
      end
    end
  end

  return false
end

newCollideSystem = world.system({Position, Velocity, Size, Collidable}, function(entity, dt)
  local dx = entity[Velocity].x * dt
  local dy = entity[Velocity].y * dt

  -- log(entity[Position].y + entity[Size].oy + entity[Size].h, true)

  -- 0 player
  -- 1 wall
  local flags = {1}

  -- Check vertical collision first
  local collist, offset = checkCollisions(entity, {0, dy}, flags)
  if collist then
    -- entity[Velocity].y = offset.y
    entity[Velocity].y = 0
    entity[Position].y = entity[Position].y + offset.y
  end

  -- Then check horizontal collision
  collist, offset = checkCollisions(entity, {dx, 0}, flags)
  if collist then
    -- entity[Velocity].x = offset.x
    entity[Velocity].x = 0
    entity[Position].x = entity[Position].x + offset.x
  end

end)


-- function is_solid(opt,obj,ox,oy,flags,debug)
-- 	local collist={}
-- 	local f={}
-- 	f.x=obj.x
-- 	f.y=obj.y
-- 	if obj.col != nil then
-- 		f.w=obj.col.w
-- 		f.h=obj.col.h
-- 		f.ox=obj.col.ox
-- 		f.oy=obj.col.oy
-- 	else
-- 		f.w=obj.w
-- 		f.h=obj.h
-- 		f.ox=obj.ox
-- 		f.oy=obj.oy
-- 	end
-- 	ox = ox or 0
-- 	oy = oy or 0
-- 	flags=flags or {0}
-- 	if(type(flags)!="table")flags={flags}
-- 	local ix=f.x+f.ox+ox
-- 	local iy=f.y+f.oy+oy
-- 	for x=ix,ix+f.w+7,8 do
-- 		for y=iy,iy+f.h+7,8 do
-- 			if opt==nil
-- 			or opt=="full"
-- 			or opt=="left" and x==ix
-- 			or opt=="right" and x>=ix+f.w
-- 			or opt=="up" and y==iy
-- 			or opt=="down" and y>=iy+f.h
-- 			or opt=="rdown" and y>=iy+f.h and x>=ix+f.w
-- 			or opt=="ldown" and x==ix and y>=iy+f.h
-- 			or opt=="rup" and y==iy and x>=ix+f.w
-- 			or opt=="lup" and y==iy and x==ix
-- 			then
-- 				add(collist, {x=min(x,ix+f.w), y=min(y,iy+f.h)})
-- 			end
-- 		end
-- 	end
-- 	if(debug)print(#collist)
-- 	for c in all(collist) do
-- 		if(debug)pset(c.x,c.y,8)
-- 		for v in all(flags) do
-- 			if(fget(mget(c.x/8,c.y/8),v))return true
-- 		end
-- 		char=get_touching_char(c.x,c.y)
-- 		if char != nil then
-- 			joka.touching=char
-- 			return true
-- 		end
-- 	end
	
-- 	return false
-- end