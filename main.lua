gd = require 'gd'

mode = "desmume"

patterns = {
	--{x = 97,   y = 9,   name = "test"},
	--{x = 50, 	 y = 1,   name = "press_start"},
	--{x = 13,   y = 131, name = "bubble"},
	{x = 50,   y = 26,  name = "soul_silver"}
}

if mode == "fceux" then
	frameadvance   = emu.frameadvance
	getscreenpixel = function(a,b,c) return emu.getscreenpixel(a,b+8,c) end
	drawimage 		 = function(a,b,c) return gui.drawimage(a,b+8,c) end
end

if mode == "vba" then
	frameadvance   = vba.frameadvance
	getscreenpixel = gui.getpixel
	drawimage			 = gui.drawimage
end

if mode == "desmume" then
	frameadvance   = emu.frameadvance
	getscreenpixel = gui.getpixel
	drawimage			 = gui.drawimage
end

function compare(x, y, input)
	for j = 0, input:sizeY()-1 do
	for i = 0, input:sizeX()-1 do
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
	for i,v in ipairs(patterns) do
		local x, y, name = v.x, v.y, v.name

		local input  = gd.createFromPng("input/"..name..".png")
		local output = gd.createFromPng("output/"..name..".png"):gdStr()

		if compare(x, y, input) then
			drawimage(x, y, output)
		end
	end
end )

while true do
	frameadvance()
end
