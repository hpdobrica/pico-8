pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
--main

function _init()
	starfield_generate()
end

function _update()
	ship_update()
	bullet_update()
	starfield_update()

end

function _draw()
	cls()
	starfield_draw()
	ship_draw()
	bullet_draw()
	ui_draw()
end


-->8
--ship

ship = {
	x=64,
	y=64,
	dx=0,
	dy=0,
	sprite=2,
	engine={
		sp={4,5,4,6,4},
		i=0
	}
	
}

function animate_engine()
		
		e=ship.engine
		e.i=(e.i+1)%#e.sp		
		
end

function ship_update()
	ship.dx=0
	ship.dy=0
	ship.sprite=2
	if btn(0) then
		ship.dx=-2
		ship.sprite=1
	end
	if btn(1) then
		ship.dx=2
		ship.sprite=3
	end
	if btn(2) then
		ship.dy=-2
	end
	if btn(3) then
		ship.dy+=2
	end
	
	ship.x+=ship.dx
	ship.y+=ship.dy
	
	if ship.x>120 then
		ship.x=0
	elseif ship.x<0 then
		ship.x=120
	end
	
	if ship.y>120 then
		ship.y=120
	elseif ship.y<0 then
		ship.y=0
	end

	animate_engine()
end

function ship_draw()
		spr(ship.sprite,ship.x,ship.y)
		spr(ship.engine.sp[ship.engine.i+1],
						ship.x,ship.y+8)
		
end
-->8
--bullet


bullets = {}

muzzle_size=0
muzzle = {
	current=0,
	maximal=3
}

bullet_tpl = {
	dy=-4
}

function bullet_update()
	
	if btnp(5) then
		local b={
			x=ship.x,
			y=ship.y-5,
			dy=bullet_tpl.dy
		}
		add(bullets,b)
		muzzle.current = muzzle.maximal
		sfx(0)
	end
	
	for i=1,#bullets do
		local b=bullets[i]
		
		if b !=nil and b.y<0 then
			del(bullets,b)
		end
	end
	
	for i=1,#bullets do
		local b=bullets[i]
		b.y+=b.dy
	end
	
	if muzzle.current > 0 then
		muzzle.current = muzzle.current-3/4
	end
end

function bullet_draw()
	for i=1,#bullets do
		local b=bullets[i]
		spr(16,b.x,b.y)
	end
	
	if muzzle.current > 1 then 
		circfill(ship.x+4,ship.y-4,
			muzzle.current,7)
	end
end
-->8
-- ui

score=0
max_lives=4
lives=3

function ui_draw()
	for i=1,max_lives do
		if i<=lives then
			spr(32,9*i,1)
		else
			spr(33,9*i,1)
		end
	end
	
	print("score: "..score,55,2,7)
end
-->8
--starfield

stars_n=64
stars_speed=6
stars={}

function starfield_generate()
 for i=1,stars_n do
 	add(stars,{
 		x=flr(rnd(128)),
 		y=flr(rnd(128))
 	})
 end
end

function starfield_update()
	for i=1,#stars do
 	stars[i].y=stars[i].y+stars_speed
 	if stars[i].y>128 then
 		stars[i].x=flr(rnd(128))
 		stars[i].y=-1
 	end
	end
end

function starfield_draw()
	 for i=1,#stars do
	 	pset(stars[i].x,stars[i].y)
	 end
end


__gfx__
00000000000880000008800000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000008800000088000000770000007700000c77c00000000000000000000000000000000000000000000000000000000000000000000000000
00700700008cc800008cc800008cc80000c77c00000770000cccccc0000000000000000000000000000000000000000000000000000000000000000000000000
0007700000ccc80008cccc80008ccc0000cccc000007700000cccc00000000000000000000000000000000000000000000000000000000000000000000000000
00077000088ee8808e8ee8e8088ee880000cc000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000eeddee0e8edde8e0eeddee000000000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000811d8808ed11de8088d1180000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000099d80008d99d80008d9900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09a7ca90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09a77a90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08800880088008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888800880080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888800000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888800000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888880080000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888800008008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00088000000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008000080008000080008000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088800888088800888088800888000000000000000000000bb00bb00bb0bbb0bbb000000000bbb000000000000000000000000000000000000000000
0000000008888888808888888808888888800000000000000000000b000b000b0b0b0b0b0000b000000b0b000000000000000000000000000000000000000000
0000000008888888808888888808888888800000000000000000000bbb0b000b0b0bb00bb0000000000b0b000000000000000000000000000000000000000000
000000000888888880888888880888888880000000000000000000000b0b000b0b0b0b0b0000b000000b0b000000000000000000000000000000000000000000
0000000000888888000888888000888888000000000000000000000bb000bb0bb00b0b0bbb000000000bbb000000000000000000000000000000000000000000
00000000000888800000888800000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000088000000088000000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000880000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000880000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000008cc8000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000008ccc000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000088ee8800000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000eeddee00000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000088d11800000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000008d99000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000c77c000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000cccccc00000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000cccc000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__sfx__
000100003405027050200501c05013050120500f0500c0500a0500a05008050060500505004050040500305003050030500305003000030000300002000020000100001000010000100001000000000000000000
