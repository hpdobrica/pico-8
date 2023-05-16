local player = world.entity({}, 
    Position({ x=30, y=30 }), 
    Size({w=1,h=6, ox=3, oy=1}),
    Velocity({ x=0, y=0, speed=3 }), 
    Renderable({ sprite=1 }), 
    Collidable(),
    Controllable(),
    Rigidbody(),
    Direction({ simple = "right", sprite={lup=17, rup=17, ldown=33, rdown=33} })
)

function drawPlayerColliders()
    pset(player[Position].x+player[Size].ox, player[Position].y+player[Size].oy+player[Size].h, 8)
    pset(player[Position].x+player[Size].ox+player[Size].w, player[Position].y+player[Size].oy+player[Size].h, 8)
    pset(player[Position].x+player[Size].ox, player[Position].y+player[Size].oy, 8)
    pset(player[Position].x+player[Size].ox+player[Size].w, player[Position].y+player[Size].oy, 8)
    
end