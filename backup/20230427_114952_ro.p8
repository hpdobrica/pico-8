pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

function _init()
  cls()

  palt(11, true) -- beige color as transparency is true
  palt(0, false) -- black color as transparency is false

	init_joka()
end

function _update()
	update_joka()
	update_camera()
end

function _draw()
	cls()
	map()
	draw_joka()
	
	--debug
	--is_solid("full",joka,0,0,{},true)

	
end
-->8
--joka


function init_joka()
	joka={
		s=1,
		w=15,
		h=23,
		ox=0,
		oy=0,
		col= {
			w=10,--15
			h=10,--15
			ox=3,--0
			oy=13,--8
		},
		x=160,
		y=60,
		sx=false,
		sy=false
	}
end

function update_joka()
	local j=joka
	local dx,dy=0,0
 if btn(⬅️) then
  j.sx = true  -- flip sprite on x
  dx=-1
 end
 if btn(➡️) then
  j.sx = false
  dx+=1  -- dx=dx+1
 end
 if btn(⬆️) then
  j.sy = false
  dy=-1
 end
 if btn(⬇️) then
  //j.sy = true  -- flip sprite on y
  dy+=1  -- dy=dy+1
 end
 
 -- there's no map-tile with
 -- flag "7" on the players'
 -- position + dx ? then move:
 if not is_solid("full",j,dx,0,7) then
  j.x+=dx
 end
 -- there's no map-tile with
 -- flag "7" on the players'
 -- position + dy ? then move:
 if not is_solid("full",j,0,dy,7) then
  j.y+=dy
 end
	
end

function draw_joka()
	local j=joka
	--spr(s.id,joka.x,joka.y,s.w,s.h)
	--sspr(8,0,16,24,joka.x,joka.y,16,24)
	spr(j.s, j.x, j.y,flr((j.w+j.ox)/8)+1,flr((j.h+j.oy)/8)+1,j.sx,j.sy)
end
-->8
-- camera

function update_camera()
	camx=joka.x-64
	camy=joka.y-64
	camera(camx,camy)
end
-->8
-- collision

function is_solid(opt,obj,ox,oy,flags,debug)
 local collist={}
 local f={}
 f.x=obj.x
 f.y=obj.y
 if obj.col != nil then
 	f.w=obj.col.w
 	f.h=obj.col.h
 	f.ox=obj.col.ox
 	f.oy=obj.col.oy
 else
 	f.w=obj.w
 	f.h=obj.h
 	f.ox=obj.ox
 	f.oy=obj.oy
 end
 ox = ox or 0
 oy = oy or 0
 flags=flags or {0}
 if(type(flags)!="table")flags={flags}
 local ix=f.x+f.ox+ox
 local iy=f.y+f.oy+oy
 for x=ix,ix+f.w+7,8 do
  for y=iy,iy+f.h+7,8 do
   if opt==nil
   or opt=="full"
   or opt=="left" and x==ix
   or opt=="right" and x>=ix+f.w
   or opt=="up" and y==iy
   or opt=="down" and y>=iy+f.h
   or opt=="rdown" and y>=iy+f.h and x>=ix+f.w
   or opt=="ldown" and x==ix and y>=iy+f.h
   or opt=="rup" and y==iy and x>=ix+f.w
   or opt=="lup" and y==iy and x==ix
   then
    add(collist, {x=min(x,ix+f.w), y=min(y,iy+f.h)})
   end
  end
 end
 if(debug)print(#collist)
 for c in all(collist) do
  if(debug)pset(c.x,c.y,8)
  for v in all(flags) do
   if(fget(mget(c.x/8,c.y/8),v))return true
  end
 end
 return false
end
__gfx__
00000000bbbb0000000bbbbb000000004447c000555555554444444477777777dddddddddd111111111111dddddddddddd111111111111dddddddddd11111111
00000000bbb044444440bbbb00000000444c7000555555554444444477777777dddddddddd111111111111dddddddddddd111111111111dddddddddd11111111
00700700bb04444444440bbb00000000444cc00055555555444444447777777711111111dd111111111111dddd111111dd111111111111dd111111dd11111111
00077000b0444444444440bb000000004447c00055555555444444447777777711111111dd111111111111dddd111111dd111111111111dd111111dd11111111
00077000044444444444440b00000000444c700055555555444444447777777711111111dd111111111111dddd111111dd111111111111dd111111dd11111111
00700700044444444444444000000000444cc00055555555444444447777777711111111dd111111111111dddd111111dd111111111111dd111111dd11111111
000000000444444444444440000000004447c00055555555444444447777777711111111dd111111111111dddd111111dddddddddddddddd111111dddddddddd
00000000044444444444444000000000444c700055555555444444447777777711111111dd111111111111dddd111111dddddddddddddddd111111dddddddddd
00000000044444f0fff0444000000000000000000000000000000000000000001111111111111111ffffffff9191919144444444666666664444444466666666
0000000004444f0fff0ff44000000000000000000000000000000000000000001111111111ffff11ffffffff191919196666666466666666444444446608a666
0000000004f44f0fff0ff40b0000000000000000000000000000000000000000111111111ffffff1ffffffff91919191666666646666666644444444660ce666
0000000004f44f0fff0ff0bb000000000000000000000000000000000000000011111111ffffffffffffffff1919191966666664666666664444444466093666
0000000004f44efffffef0bb000000000000000000000000000000000000000011111111ffffffffffffffff9191919166666664666666664444444466066666
0000000004444ffffffff0bb000000000000000000000000000000000000000011111111ffffffff1ffffff11919191966666664666666664444444460006666
0000000004444ff88ffff0bb000000000000000000000000000000000000000011111111ffffffff11ffff119191919166666664666666664444444466666666
000000000444000ff00040bb000000000000000000000000000000000000000011111111ffffffff111111111919191966666664666666664446644466666666
0000000004409999999040bb0000000000000000000000000000000000000000444444444444444440000000000000044444444446aaaa666666666400000000
000000000409909999900bbb0000000000000000000000000000000000000000400000000000000440000000000000044666666646aaaa666666666400000000
00000000b0990999999090bb00000000000000000000000000000000000000004000000000000004400000000000000446eee66646aaaa666655556400000000
00000000b0ff09999990f0bb00000000000000000000000000000000000000004000005555000004400000000000000446eee66646a00a666656756400000000
00000000b0ff0aaaaaa0f0bb0000000000000000000000000000000000000000400000000000000440000000000000044633366646aaaa666657056400000000
00000000bb00000000000bbb00000000000000000000000000000000000000004000000000000004400000000000000446333666466666666655556400000000
00000000bbb0a0bbb0a0bbbb00000000000000000000000000000000000000004000000000000004400000000000000446666666466666666666666400000000
00000000bbb0d0bbb0d0bbbb00000000000000000000000000000000000000004000000000000004444444444444444446666666444444444444444400000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb0000bbbbb0000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb0999000009990b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbb00999999900bb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb099999990bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb090999090bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb099999990bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb099909990bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb099909990bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb099090990bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbb9bbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
70606060606060606060606060606060606060606060606060606060607060606060606060606060700000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70707070707070707070707070707070707070707070707070707070707070707070707070707070700000000000000000000000000000000000000000000000
__gff__
0000000080000080000000000000000000000000000000000000000080800080000000000000000000000000808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0707070707070707070707070707070707070707070707070707070707070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070606060606060606060606060606060606070b08080808080e061f1d1d1d07000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070606060606060606060606060606060606070919181b1b1b0a061d1d1d1d07000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07060606060606060606060606060606060607091a181b1b1b0a062829060604000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070606060606060606060606060606060606070919181b1b1b0a062a2b060604000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07060606060606060606060606060606060607091a181b1b1b0a060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070606060606060606060606060606060606070c0f0f0f0f0f0d060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606061e061e0607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606062c1c1d1d1d1d1d07000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606062d2e1d1d1d1d1d07000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707050507070707070705050707070707070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0705050505050505050505070505050505050505050505050505050505050507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0705050505050505050505070505050505050505050505050505050505050507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0705050505050505050505050505050505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0705050505050505050505050505050505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0705050505050505050505070505050505050505050505050505050505050507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0705050505050505050505070505050505050505050505050505050505050507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707050507070707070707070707070707070707070707101007070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060606060606060606060606070606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
