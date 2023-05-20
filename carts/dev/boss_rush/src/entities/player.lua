local player = world.entity({}, 
    Position({ x=30, y=30 }), 
    Size({w=1,h=6, ox=3, oy=1}),
    Velocity({ x=0, y=0, speed=3 }), 
    Renderable({ sprite=1 }), 
    Collidable(),
    Controllable(),
    Rigidbody(),
    Direction({ angle = 0, step_lock=8, sprite={} })
)

player[Direction].sprite[0.125] = 33 -- rdown
player[Direction].sprite[0.375] = 33 -- ldown
player[Direction].sprite[0.625] = 17 -- lup
player[Direction].sprite[0.875] = 17 -- rup
player[Direction].sprite[0.75] = 17 -- up 
player[Direction].sprite[0.25] = 33 -- down


function debugPlayer()
    -- colliders
    -- pset(player[Position].x+player[Size].ox, player[Position].y+player[Size].oy+player[Size].h, 8)
    -- pset(player[Position].x+player[Size].ox+player[Size].w, player[Position].y+player[Size].oy+player[Size].h, 8)
    -- pset(player[Position].x+player[Size].ox, player[Position].y+player[Size].oy, 8)
    -- pset(player[Position].x+player[Size].ox+player[Size].w, player[Position].y+player[Size].oy, 8)
    print(player[Velocity].y)
    
end