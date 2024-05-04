extends TileMap

const sourceId := 0
@export var speed := 64

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

	astar.connect_points(0, 1)
	astar.connect_points(1, 2)
	astar.connect_points(20, 21)
	astar.connect_points(30, 31)
	astar.connect_points(31, 32)

	astar.connect_points(0, 10)
	astar.connect_points(10, 20)
	astar.connect_points(20, 30)
	astar.connect_points(11, 21)
	astar.connect_points(2, 12)
	astar.connect_points(12, 22)
	astar.connect_points(22, 32)

	$Dot.position = Vector2(64, 64)

func __set_tile(tile_pos: Vector2i, tileset_idx: int) -> void:
	set_cell(0, tile_pos, sourceId, Vector2i(tileset_idx, 0))
	astar.add_point(tilepos_to_tileidx(tile_pos), 128*Vector2(tile_pos.x+0.5, tile_pos.y+0.5))

func tilepos_to_tileidx(tile_pos: Vector2i) -> int:
	return tile_pos.x + 10*tile_pos.y

func _process(delta):
	if remaining_path.size() == 0:
		$Dot.stop()
		return
	$Dot.play()
	var next_goal = remaining_path[0]
	var direction = next_goal - $Dot.position
	var position = $Dot.position + (speed * direction.normalized() * delta)
	position = oriented_clamp(position, $Dot.position, next_goal)
	$Dot.position = position

	if (position == next_goal):
		print("tempGT: reach goal at " + str(next_goal))
		remaining_path.remove_at(0)

func oriented_clamp(to_clamp: Vector2, limit1: Vector2, limit2: Vector2) -> Vector2:
	var min_vec = Vector2(min(limit1.x, limit2.x), min(limit1.y, limit2.y))
	var max_vec = Vector2(max(limit1.x, limit2.x), max(limit1.y, limit2.y))
	return to_clamp.clamp(min_vec, max_vec)

func _input(event):
	if event.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos: Vector2i = local_to_map(mouse_pos)
		if not is_set_tile(tile_pos):
			print("click outside of the board, we ignore it")
			return

		var path = astar.get_point_path(tilepos_to_tileidx(get_dot_tile_pos()), tilepos_to_tileidx(tile_pos))
		remaining_path = path

func get_dot_tile_pos() -> Vector2i:
	return local_to_map($Dot.position)

func is_set_tile(tile_pos: Vector2i):
	return get_cell_atlas_coords(0, tile_pos) != Vector2i(-1, -1)
