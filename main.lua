memoize = require('lib.knife.memoize')
image   = require('lib.cargo').init('img')
root    = require('root')

target = 17270
count  = 0
flag = {}

love.update = function()
  if target > count then
    count = count + 1
  end

  scan(root, frame(count) )
end

love.draw = function ()
  love.graphics.draw( frame(count) )
  love.graphics.print(tostring(flag.bubble), 0, 162)
  love.graphics.print(tostring(flag.gender), 0, 186)
end

love.keypressed = function(key)
  target = target + 60

  if target > 17270 then target = 17270 end
end

frame = function(name)
  return love.graphics.newImage("frame/"..name..".png")
end

pixels = memoize( function(frame)
  return frame:getData()
end )

scan = function(children, frame)
  if frame:type() ~= "ImageData" then
    frame = frame:getData()
  end

  for _,child in pairs(children) do
    local pattern = pixels(child.image)

    flag[child.name] = false

    if compare(frame, pattern, child) then
      flag[child.name] = true

      if child.children then
        scan(child.children, frame)
      end
    end
  end
end

compare = function(frame, pattern, child)
  for y = 0, pattern:getHeight()-1 do
    for x = 0, pattern:getWidth()-1 do
      local r1, g1, b1 = frame:getPixel(x + child.x, y + child.y)
      local r2, g2, b2 = pattern:getPixel(x, y)

      if r1 ~= r2 or g1 ~= g2 or b1 ~= b2 then
        return false
      end
    end
  end

  return true
end
