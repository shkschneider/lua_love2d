Vector = luax.Class:new()

function Vector:constructor(x, y)
  self.x = x or _G.width / 2
  self.y = y or _G.height / 2
end

function Vector:copy()
  return Vector(self.x, self.y)
end

function Vector:zero()
  return Vector(0, 0)
end

function Vector:random()
  local theta = math.random() * math.pi * 2
  return Vector(math.cos(theta), math.sin(theta))
end

function Vector:center()
  return Vector(_G.width / 2, _G.height / 2)
end

function Vector:mouse()
  return Vector(love.mouse.getX(), love.mouse.getY())
end

--[[ computations ]]--

function Vector:dot(vector)
  return self.x * vector.x + self.y * vector.y
end

function Vector:heading() -- rad
  return -math.atan2(self.y, self.x)
end

function Vector:rotate(theta)
  self.x = self.x * math.cos(theta) - self.y * math.sin(theta)
  self.y = self.x * math.sin(theta) + self.y * math.cos(theta)
  return self
end

function Vector:translate(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
  return self
end

function Vector:distance(vector)
  return (self:copy() - vector):magnitude()
end

function Vector:scale(dx, dy)
  self.x = self.x * (dx or 1)
  self.y = self.y * (dy or 1)
  return self
end

function Vector:magnitude() -- length
  return math.sqrt(self.x ^ 2 + self.y ^ 2)
end

function Vector:angle(vector) -- rad
  if vector then
    return math.atan2(vector.x - self.x, self.y - vector.y)
  else
    return math.atan(self.y / self.x)
 end
end

function Vector:sqrt()
   return math.sqrt(self:dot(self))
end

function Vector:normalize()
  return Vector(self.x, self.y) / self:sqrt()
end

function Vector:isParallel(vector)
  return math.abs(self:dot(vector)) == 1
end

function Vector:unpack()
  return self.x, self.y
end

--[[ operators ]]--

Vector.__tostring = function (vector)
   return "(" .. vector.x .. "," .. vector.y .. ")"
end

Vector.__unm = function (vector)
  return Vector(-vector.x, -vector.y)
end

Vector.__eq = function (vector1, vector2)
  return vector1.x == vector2.x and vector1.y == vector2.y
end

local function _tovector(vectorOrNumber)
  if type(vectorOrNumber) == "number" then
    return Vector(vectorOrNumber, vectorOrNumber)
  else
    return vectorOrNumber
  end
end

Vector.__add = function (vector, vectorOrNumber)
  vector.x = vector.x + _tovector(vectorOrNumber).x
  vector.y = vector.y + _tovector(vectorOrNumber).y
  return vector
end

Vector.__sub = function (vector, vectorOrNumber)
  vector.x = vector.x - _tovector(vectorOrNumber).x
  vector.y = vector.y - _tovector(vectorOrNumber).y
  return vector
end

Vector.__mul = function (vector, vectorOrNumber)
  vector.x = vector.x * _tovector(vectorOrNumber).x
  vector.y = vector.y * _tovector(vectorOrNumber).y
  return vector
end

Vector.__div = function (vector, vectorOrNumber)
  vector.x = vector.x / _tovector(vectorOrNumber).x
  vector.y = vector.y / _tovector(vectorOrNumber).y
  return vector
end

--[[ tostring() ]]--

Vector.__tostring = function (self)
  return "(" .. tostring(self.x) .. "," .. tostring(self.y) .. ")"
end

return Vector
