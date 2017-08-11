import godot
import math

const up* = vec2(0, -1)
const down* = vec2(0, 1)
const left* = vec2(-1, 0)
const right* = vec2(1, 0)
const none* = vec2(0, 0)

const cellSize* = 32
const cellDim* = vec2(32, 32)
const quarter* = PI / 2

var cellUp* = up * cellSize
var cellDown* = down * cellSize
var cellLeft* = left * cellSize
var cellRight* = right * cellSize

proc align*(vec: Vector2): Vector2 =
  return vec.snapped(cellDim)

proc toCardinal*(vec: Vector2): Vector2 =
  var angle = quarter * round(vec.angle() / quarter)
  case angle
    of 0.0: return right
    of quarter: return down
    of PI, -PI: return left
    of -quarter: return up
    else: return none
