local player = world.entity({}, 
    Position({ x=1, y=1 }), 
    Size({w=1,h=1, ox=0, oy=0}),
    Renderable({ sprite=1 }), 
    Collidable(),
    Controllable(),
    Direction({ angle = 0, step_lock=8, sprite={} }),
    Health({ max=10, current=10 })
)



function debugPlayer()
    -- colliders
    -- pset(player[Position].x+player[Size].ox, player[Position].y+player[Size].oy+player[Size].h, 8)
    -- pset(player[Position].x+player[Size].ox+player[Size].w, player[Position].y+player[Size].oy+player[Size].h, 8)
    -- pset(player[Position].x+player[Size].ox, player[Position].y+player[Size].oy, 8)
    -- pset(player[Position].x+player[Size].ox+player[Size].w, player[Position].y+player[Size].oy, 8)
    -- print(player[Velocity].y)
    
end