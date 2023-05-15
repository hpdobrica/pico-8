


function init_game()
  -- set green as transparent
  palt(0, false)
  palt(11, true)

  fps=stat(8)

  log("new game start, clearing log", true)
  
end



world = pecs()

Position = world.component({ x=0, y=0})
Size = world.component({ w=0, h=0, ox=0, oy=0})
Velocity = world.component({ x=0, y=0, speed=1})
Renderable = world.component({ sprite=0 })
Collidable = world.component({})
Controllable = world.component({})
Rigidbody = world.component({})

local player = world.entity({}, 
          Position({ x=30, y=30 }), 
          Size({w=1,h=6, ox=3, oy=1}),
          Velocity({ x=0, y=0, speed=3 }), 
          Renderable({ sprite=1}), 
          Collidable(),
          Controllable(),
          Rigidbody()
        )

local boss = world.entity({}, 
  Position({ x=60, y=90 }), 
  Size({w=16,h=16, ox=0, oy=0}),
  Velocity({ x=0, y=0, speed=3 }), 
  Renderable({ sprite=224}), 
  Collidable(),
  -- Controllable(),
  Rigidbody()
)

local moveSystem = world.system({ Position, Velocity }, function(entity, dt)
  entity[Position].x += entity[Velocity].x * dt
  entity[Position].y += entity[Velocity].y * dt
end)

local renderSystem = world.system({ Position, Renderable, Size }, function(entity)
  spr(entity[Renderable].sprite, entity[Position].x, entity[Position].y, ceil(entity[Size].w/8), ceil(entity[Size].h/8))
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
    entity[Velocity].y = -speed * 3
  end
end)

local rigidbodySystem = world.system({ Rigidbody, Velocity }, function(entity, dt)
  entity[Velocity].y += 2 * dt
end)

local lastTick = time()


function _init()
  init_game()
end

function _update()
  
  local tick = time()
  local dt = 1
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
  pset(player[Position].x+player[Size].ox+player[Size].w, player[Position].y+player[Size].oy+player[Size].h, 8)
  pset(player[Position].x+player[Size].ox, player[Position].y+player[Size].oy, 8)
  pset(player[Position].x+player[Size].ox+player[Size].w, player[Position].y+player[Size].oy, 8)
  
end




