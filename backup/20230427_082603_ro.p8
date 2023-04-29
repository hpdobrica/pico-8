pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

function _init()
  cls()

  palt(7, true) -- beige color as transparency is true
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
		x=30,
		y=30,
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
00000000777700000007777777444477744444475555555544444444666666660000000000000000000000000000000000000000000000000000000000000000
000000007770444444407777774fff77744444475555555544444444666666660000000000000000000000000000000000000000000000000000000000000000
007007007704444444440777774fff77744ffff75555555544444444666666660000000000000000000000000000000000000000000000000000000000000000
00077000704444444444407777411177744ff0f75555555544444444666666660000000000000000000000000000000000000000000000000000000000000000
00077000044444444444440777111177744ffff75555555544444444666666660000000000000000000000000000000000000000000000000000000000000000
0070070004444444444444407711f177744ffff75555555544444444666666660000000000000000000000000000000000000000000000000000000000000000
00000000044444444444444077111177744ff8875555555544444444666666660000000000000000000000000000000000000000000000000000000000000000
00000000044444444444444077722777744111175555555544444444666666660000000000000000000000000000000000000000000000000000000000000000
00000000044444f0fff0444077777777744111170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004444f0fff0ff44077777777711111170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004f44f0fff0ff4077777777771111f170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004f44f0fff0ff0777777777771111f170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004f44efffffef07777777777711111170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004444ffffffff07777777777772772770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004444ff88ffff07777777777772772770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000444000ff000407777777777772772770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000044099999990407700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000040990999990077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000709909999990907700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000070ff09999990f07700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000070ff0aaaaaa0f07700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000770000000000077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007770a07770a0777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007770d07770d0777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
70606060606060606060606060606060606060606060606060606060607060606060606060606060700000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70707070707070707070707070707070707070707070707070707070707070707070707070707070700000000000000000000000000000000000000000000000
__gff__
0000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0707070707070707070707070707070707070707070707070707070707070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060606060606060606060706060606060606060606060607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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