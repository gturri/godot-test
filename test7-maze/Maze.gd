extends TileMap

const sourceId = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_cell(0, Vector2i(0, 0), sourceId, Vector2i(6, 0))
	set_cell(0, Vector2i(0, 1), sourceId, Vector2i(1, 0))
	set_cell(0, Vector2i(0, 2), sourceId, Vector2i(4, 0))
	set_cell(0, Vector2i(0, 3), sourceId, Vector2i(7, 0))

	set_cell(0, Vector2i(1, 0), sourceId, Vector2i(0, 0))
	set_cell(0, Vector2i(1, 1), sourceId, Vector2i(1, 0))
	set_cell(0, Vector2i(1, 2), sourceId, Vector2i(8, 0))
	set_cell(0, Vector2i(1, 3), sourceId, Vector2i(0, 0))

	set_cell(0, Vector2i(2, 0), sourceId, Vector2i(9, 0))
	set_cell(0, Vector2i(2, 1), sourceId, Vector2i(1, 0))
	set_cell(0, Vector2i(2, 2), sourceId, Vector2i(1, 0))
	set_cell(0, Vector2i(2, 3), sourceId, Vector2i(8, 0))

func _process(delta):
	pass
