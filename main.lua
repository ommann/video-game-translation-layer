gd = require 'gd'

mode = "fceux"

if mode == "fceux" then
	frameadvance   = emu.frameadvance
	getscreenpixel = function(a,b,c) return emu.getscreenpixel(a,b+8,c) end
	drawimage 		 = function(a,b,c) return gui.drawimage(a,b+8,c) end
	file = "score"
	x,y = 97,176
end

if mode == "vba" then
	frameadvance   = vba.frameadvance
	getscreenpixel = gui.getpixel
	drawimage			 = gui.drawimage
	file = "press_start"
	x,y = 50,1
end

input  = gd.createFromPng("input/"..file..".png")
output = gd.createFromPng("output/"..file..".png"):gdStr()

function compare(x, y, input)
	for i = 0, input:sizeX()-1 do
		for j = 0, input:sizeY()-1 do
			local r1, g1, b1 = getscreenpixel(x+i, y+j, true)
			local a2, r2, g2, b2 = gui.parsecolor( input:getPixel(i, j) )

			if r1 ~= r2 or g1 ~= g2 or b1 ~= b2 then
				return false
			end
		end
	end

	return true
end

gui.register( function()
		if compare(x, y, input) then
			drawimage(x, y, output)
		end
end )

while true do
	frameadvance()
end
