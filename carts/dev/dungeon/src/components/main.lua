
Position = world.component({ x=0, y=0})
Size = world.component({ w=0, h=0, ox=0, oy=0})
Velocity = world.component({ x=0, y=0, speed=1})
Renderable = world.component({ sprite=0, flipXEnabled=true, flipYEnabled=false})
Collidable = world.component({})
Controllable = world.component({})
Rigidbody = world.component({})
-- Direction = world.component({ angle=nil, simple="right", sprite={} }) -- sprite{left=nil, lup=nil, ldown=nil, right=nil, rup=nil, rdown=nil, up=nil, down=nil}
Direction = world.component({ angle=nil, step_lock=nil, sprite={} }) -- sprite{left=nil, lup=nil, ldown=nil, right=nil, rup=nil, rdown=nil, up=nil, down=nil}

function setDirection(dirObj, angle)
    if dirObj.round_to_step ~= nil then
        dirObj.angle = roundToStep(angle, dirObj.round_to_step)
    else 
        dirObj.angle = angle
    end
    return dirObj
end

Lifetime = world.component({ duration=0 })
Damage = world.component({ amount=0 })
Health = world.component({ current=0, max=0 })

Action = world.component({ action=nil, delay=0, cooldown=0, state="init", type=nil })

-- actions
Attack = world.component({ damage=0, range=0, sprite=0, duration=0 })
-- todo figure out direction of attack
-- maybe instead of storing simple direction, calculate angle based on it?
-- dunno whats easier, will have to draw attack
-- either to the left or under angle?