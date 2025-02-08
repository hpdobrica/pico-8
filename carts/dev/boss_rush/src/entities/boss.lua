
local boss = world.entity({}, 
  Position({ x=60, y=90 }), 
  Size({w=16,h=16, ox=0, oy=0}),
  Velocity({ x=0, y=0, speed=3 }), 
  Renderable({ sprite=224}), 
  Collidable(),
  -- Controllable(),
  Rigidbody(),
  Health({ max=3, current=3 })
)
