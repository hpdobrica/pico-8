


function init_game()
  -- set green as transparent
  palt(0, false)
  palt(11, true)

  fps=stat(8)

  log("new game start, clearing log", true)
  
end



local world = pecs()

local Position = world.component({ x=0, y=0})
local Size = world.component({ w=0, h=0, ox=0, oy=0})
local Velocity = world.component({ x=0, y=0, speed=1})
local Renderable = world.component({ sprite=0 })
local Collidable = world.component({})
local Controllable = world.component({})
local Rigidbody = world.component({})

local player = world.entity({}, 
          Position({ x=30, y=30 }), 
          Size({w=1,h=6, ox=3, oy=1}),
          Velocity({ x=0, y=0, speed=2000 }), 
          Renderable({ sprite=1}), 
          Collidable(),
          Controllable(),
          Rigidbody()
        )


local moveSystem = world.system({ Position, Velocity }, function(entity, dt)
  entity[Position].x += entity[Velocity].x * dt
  entity[Position].y += entity[Velocity].y * dt
end)

local renderSystem = world.system({ Position, Renderable }, function(entity)
  spr(entity[Renderable].sprite, entity[Position].x, entity[Position].y)
end)

local collideSystem = world.system({ Position, Velocity, Size, Collidable }, function(entity, dt)
  local x = entity[Position].x
  local y = entity[Position].y
  local w = entity[Size].w
  local h = entity[Size].h

 

  
  -- if flag 1 based on velocity then wall
  if entity[Velocity].x > 0 then
    if fget(mget((x+w)/8, y/8),1) then
      log(1)
      entity[Velocity].x = 0
    end
  elseif entity[Velocity].x < 0 then
    if fget(mget(x/8, y/8),1) then
      log(2)
      entity[Velocity].x = 0
    end
  end
  
  if entity[Velocity].y > 0 then
    if fget(mget(x/8, (y+h)/8), 1) then
      log(3)
      entity[Velocity].y = 0
    end
  elseif entity[Velocity].y < 0 then
    if fget(mget(x/8, y/8),1) then
      log(4)
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

  for tx = ix, ix + w + 7, 8 do
    for ty = iy, iy + h + 7, 8 do
      tx = min(tx, ix + w)
      ty = min(ty, iy + h)
      for _, v in pairs(flags) do
        if fget(mget(tx/8, ty/8), v) then
          return true, {x=tx, y=ty}
        end
      end
    end
  end
  return false
end

local newCollideSystem = world.system({ Position, Velocity, Size, Collidable }, function(entity, dt)
  local dx = entity[Velocity].x * dt
  local dy = entity[Velocity].y * dt

  log(entity[Position].y+entity[Size].oy+entity[Size].h, true)
  

  -- 0 player
  -- 1 wall
  local flags = {1}

  -- Check vertical collision first
  local collist = checkCollisions(entity, {0, dy}, flags)
  if collist then
    entity[Velocity].y = 0
  end

  -- Then check horizontal collision
  collist = checkCollisions(entity, {dx, 0}, flags)
  if collist then
    entity[Velocity].x = 0
  end

	

end)




local controlSystem = world.system({ Controllable, Velocity }, function(entity, dt)

  local speed = entity[Velocity].speed * dt
  if btn(0) then
    entity[Velocity].x = -speed
  elseif btn(1) then
    entity[Velocity].x = speed
  else
    entity[Velocity].x = 0
  end
  
  if btn(2) then
    entity[Velocity].y = -speed
  elseif btn(3) then
    entity[Velocity].y = speed
  else
    entity[Velocity].y = 0
  end

  if btnp(4) then
    entity[Velocity].y = -speed * 10
  end
end)

local rigidbodySystem = world.system({ Rigidbody, Velocity }, function(entity, dt)
  entity[Velocity].y += 100 * dt
end)

local lastTick = time()


function _init()
  init_game()
end

function _update()
  
  local tick = time()
  local dt = 1 / fps
  world.update()

  controlSystem(dt)

  rigidbodySystem(dt)
  newCollideSystem(dt)
  moveSystem(dt)


  lastTick = time()
  
  
end

function _draw()
  cls(7)
  map()
  
  renderSystem()
  pset(player[Position].x+player[Size].ox, player[Position].y+player[Size].oy+player[Size].h, 8)

  
  
end





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