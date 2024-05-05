extends TileMap

const sourceId := 0
@export var speed := 256

var astar := AStar2D.new()
var remaining_path := PackedVector2Array()



func _ready():
	__set_tile(Vector2i(0, 0), 6)
	__set_tile(Vector2i(0, 1), 1)
	__set_tile(Vector2i(0, 2), 4)
	__set_tile(Vector2i(0, 3), 7)

	__set_tile(Vector2i(1, 0), 0)
	__set_tile(Vector2i(1, 1), 1)
	__set_tile(Vector2i(1, 2), 8)
	__set_tile(Vector2i(1, 3), 0)

	__set_tile(Vector2i(2, 0), 9)
	__set_tile(Vector2i(2, 1), 1)
	__set_tile(Vector2i(2, 2), 1)
	__set_tile(Vector2i(2, 3), 8)

	$MazeCharacter.position = Vector2(64, 64)

func __set_tile(tile_pos: Vector2i, tileset_idx: int) -> void:
	set_cell(0, tile_pos, sourceId, Vector2i(tileset_idx, 0))

func tilepos_to_tileidx(tile_pos: Vector2i) -> int:
	return tile_pos.x + 10*tile_pos.y

func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		$MazeCharacter.set_movement_target(mouse_pos)
