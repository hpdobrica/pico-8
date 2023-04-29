pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
--main

function _init()
	mode_start()
end



function _update()
	if modes[mode].update != nil then
		modes[mode].update()
	end
end


function _draw()
	cls()
	if modes[mode].draw != nil then
		modes[mode].draw()
	end

end




-->8
-- ship

-- ship
function ship_init()

	ship = {
		x=64,
		y=64,
		dx=0,
		dy=0,
		spr=2,
		engine={
			sprites={4,5,4,6,4},
			spr_id=0,
			spr=nil
		}
	}
	ship_engine = {
		x=ship.x,
		y=ship.y+8,
		sprites={4,5,4,6,4},
		spr_id=1
	}
end

function ship_update()
	ship.dx=0
	ship.dy=0
	ship.spr=2
	if btn(0) then
		ship.dx=-2
		ship.spr=1
	end
	if btn(1) then
		ship.dx=2
		ship.spr=3
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

	ship_engine.x=ship.x
	ship_engine.y=ship.y+8
	animate_sprite(ship_engine)
end

function ship_draw()
		draw_sprites({ship,ship_engine})
end
-->8
--bullet

function bullets_init()
	bullets = {}

	muzzle_size=0
	muzzle = {
		current=0,
		maximal=3
	}
	
	bullet_dy=-4
end

function bullet_update()
	
	if btnp(5) then
		local b={
			x=ship.x,
			y=ship.y-5,
			dy=bullet_dy
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


function game_ui_init()
	score=0
	max_lives=3
	lives=3
end


function game_ui_draw()
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



function starfield_init()
	stars_n=100
	stars={}
	
 for i=1,stars_n do
 	add(stars,{
 		x=flr(rnd(128)),
 		y=flr(rnd(128)),
 		s=rnd(2)+0.5
 	})
 end
end

function starfield_update()
	for i=1,#stars do
 	stars[i].y=stars[i].y+stars[i].s
 	if stars[i].y>128 then
 		stars[i].x=flr(rnd(128))
 		stars[i].y=-1
 	end
	end
end

function starfield_draw()
	 for i=1,#stars do
	 	local s=stars[i]
	 	local c=6
	 	if s.s < 1 then
	 		c=1
	 	elseif s.s <1.5 then
	 		c=13
	 	end
	 	
	 	if s.s < 2 then
	 		pset(s.x,s.y,c)
	 	else
	 		line(s.x,s.y,s.x,s.y-3,c)
	 	end
	 end
end


-->8
--modes

modes = {
	start = {},
	game = {},
	over = {}
}

-- start
function mode_start()
	mode="start"
	start_i=0
	start_c={5,5,5,5,5,5,5,5,6,6,7,7,6,6,5,5}
end

modes.start.update = function()
	start_i+=1
	if start_i>#start_c then
		start_i = 1
	end
	if btnp(4) or btnp(5) then
		mode_game()
	end
end

modes.start.draw = function()
	print("shmup!",55,35,12)
	print("press any key to start",23,70,start_c[start_i])
end



-- game
function mode_game()
	mode="game"
	starfield_init()
	ship_init()
	bullets_init()
	enemies_init()
	game_ui_init()
end

modes.game.update = function()
	ship_update()
	bullet_update()
	enemies_update()
	starfield_update()
	
end

modes.game.draw=function()
	starfield_draw()
	ship_draw()
	bullet_draw()
	enemies_draw()
	game_ui_draw()
end

-- over
function mode_over()
	mode="over"
end

modes.over.update = function()
	if btnp(4) or btnp(5) then
		mode_game()
	end
end

modes.over.draw = function()
	cls(8)
	print("game over!",55,35,12)
	print("press any key to continue",23,70,7)
end


-->8
--enemies


function enemies_init()
	enemies_cfg = {
		n=1,
		sprites={8,8,8,8,8,8,8,8,8,8,9,9,8,8,7,7}
	}
	enemies = {}
	for i=1,enemies_cfg.n do
			add(enemies,{
				x=60,
				y=10,
				dx=0,
				dy=1,
				spr_id=1,
				spr=nil
			})
	end
end

function enemies_update()
	local cfg=enemies_cfg
	
	for e in all(enemies) do
		animate_sprite(e,enemies_cfg.sprites)

		
		--move
		--e.dx=(-1)^rnd({1,2})          
		e.x+=e.dx
		e.y+=e.dy
		
	end
	
end

function enemies_draw()
	draw_sprites(enemies)
end
-->8
--util

function draw_sprites(objs)
	for o in all(objs) do
		spr(
			o.spr,o.x,o.y)
	end
end

function animate_sprite(obj,sprites)
	if sprites == nil then
		sprites=obj.sprites
	end
	
	obj.spr_id+=1
	if obj.spr_id>#sprites then
		obj.spr_id=1
	end
	obj.spr=sprites[obj.spr_id]

end
__gfx__
00000000000880000008800000088000000000000000000000000000033003300330033003300330000000000000000000000000000000000000000000000000
00000000000880000008800000088000000770000007700000c77c0033b33b3333b33b3333b33b33000000000000000000000000000000000000000000000000
00700700008cc800008cc800008cc80000c77c00000770000cccccc03bbbbbb33bbbbbb33bbbbbb3000000000000000000000000000000000000000000000000
0007700000ccc80008cccc80008ccc0000cccc000007700000cccc003b7717b33b7717b33b7717b3000000000000000000000000000000000000000000000000
00077000088ee8808e8ee8e8088ee880000cc000000cc000000000000b7117b00b7117b00b7117b0000000000000000000000000000000000000000000000000
007007000eeddee0e8edde8e0eeddee000000000000cc00000000000003773000037730000377300000000000000000000000000000000000000000000000000
000000000811d8808ed11de8088d1180000000000000000000000000030330300303303003033030000000000000000000000000000000000000000000000000
000000000099d80008d99d80008d9900000000000000000000000000300000030300003000300300000000000000000000000000000000000000000000000000
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