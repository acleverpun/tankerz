const up = Vector2(0, -1)
const down = Vector2(0, 1)
const left = Vector2(-1, 0)
const right = Vector2(1, 0)
const none = Vector2(0, 0)

const cellSize = 32
const cellDim = Vector2(32, 32)
const quarter = PI / 2
const negQuarter =  -quarter

const cellUp = cellSize * up
const cellDown = cellSize * down
const cellLeft = cellSize * left
const cellRight = cellSize * right

static func align(vec):
	return vec.snapped(cellDim)

static func toCardinal(vec):
	var angle = quarter * round(vec.angle() / quarter)
	match angle:
		0.0, -0.0: return right
		quarter: return down
		PI, -PI: return left
		negQuarter: return up
		_: return none
