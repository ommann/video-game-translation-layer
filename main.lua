memoize = require('lib.knife.memoize')
image   = require('lib.cargo').init('img')
layer   = require('lib.cargo').init('output')
root    = require('root')

target = 17270
count  = 0
flag = {}

output = {x = 242, y = 0}

love.update = function()
  if target > count then
    count = count + 1
  end

  scan(root, frame(count) )
end

love.draw = function ()
  love.graphics.draw( frame(count) )
  love.graphics.draw( frame(count), output.x, output.y )

  draw_layer(flag, root)
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

      if child.children then                  --else stop scanning?
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

draw_layer = function(flag, children)
  for name,child in pairs(children) do
    if flag[name] then
      love.graphics.draw( layer[name], output.x + child.x, output.y + child.y )

      if child.children then draw_layer(flag, child.children ) end
    end
  end
end
