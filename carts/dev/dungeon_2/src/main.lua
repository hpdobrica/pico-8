


function init_game()
  -- set green as transparent
  palt(0, false)
  palt(11, true)

  fps=stat(8)

  log("new game start, clearing log", true)
  
end









local moveSystem = world.system({ Position, Velocity }, function(entity, dt)
  entity[Position].x = entity[Position].x + entity[Velocity].x * dt
  entity[Position].y = entity[Position].y + entity[Velocity].y * dt
end)




local rigidbodySystem = world.system({ Rigidbody, Velocity }, function(entity, dt)
  entity[Velocity].y = min(entity[Velocity].y + 2 * dt,15)
end)

local lastTick = time()


function _init()
  init_game()
end


function _update()
  
  local tick = time()
  local dt = 1
  world.update()

  lifetimeSystem(dt)
  controlSystem(dt)

  rigidbodySystem(dt)

  actionSystem(dt)
  attackSystem(dt)
  newCollideSystem(dt)
  damageSystem(dt)
  healthSystem(dt)
  moveSystem(dt)


  lastTick = time()
  
end

function _draw()
  cls(7)
  map()
  
  renderSystem()
  debugPlayer()
end




