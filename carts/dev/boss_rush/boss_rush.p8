pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

#include src/util/main.lua
#include src/util/debug.lua
#include src/util/pecs.lua


#include src/init.lua



#include src/components/main.lua

#include src/entities/player.lua
#include src/entities/boss.lua

#include src/main.lua

#include src/systems/render.lua
#include src/systems/control.lua
#include src/systems/action.lua
#include src/systems/collision.lua
__gfx__
00000000bbbbbbbb6666666677777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb55bbb7677677677777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbbdcbbb6776776777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bbb55bbb7767767777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bbbd5bbb7677677677777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbb55bbb6776776777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbd5bbb7767767777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb55bbb6666666677777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb5cbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbd5bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb55bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbd5bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb55bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbd5bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb55bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb55bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbd5bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb5cbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbd5bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb55bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbd5bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbb55bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbccbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbcbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbcbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbcbbbbbbbccccb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbccbbbbbbccbbcb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bccbbbbbbccbbbbc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccbbbbbbccbbbbbc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbb888888bbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbb8800000088bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb800000000008bb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b80000000000008b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b80000000000008b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000008000800080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b80000888888008b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b80000000000008b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb800000000008bb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbb8800000088bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbb888888bbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0001020000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000404000000000000000000000000000004040000000000000000000000000000
__map__
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020203030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020203030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020203030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
