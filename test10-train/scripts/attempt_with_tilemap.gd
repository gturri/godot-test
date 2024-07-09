extends TileMap

const RIGHT=0
const UP=1
const LEFT=2
const DOWN=3

var cell_to_path := {}
const tileset_source_id = 2

@export var speed: float = 5

var current_LocationAndSpeedMetadata: LocationAndSpeedMetadata

# Called when the node enters the scene tree for the first time.
func _ready():
	add_tile(Vector2i(0, 0), 4)
	add_tile(Vector2i(1, 0), 0)
	add_tile(Vector2i(2, 0), 5)
	#add_tile(Vector2i(2, 1), 1)
	add_tile(Vector2i(2, 2), 2)
	add_tile(Vector2i(1, 2), 0)
	add_tile(Vector2i(0, 2), 3)
	add_tile(Vector2i(0, 1), 1)

	current_LocationAndSpeedMetadata = LocationAndSpeedMetadata.new(Vector2i(0, 0), true)

func set_train_position() -> void:
	var path_follow: PathFollow2D = cell_to_path[current_LocationAndSpeedMetadata.cell_coords].get_node("PathFollow2D")
	path_follow.set_progress_ratio(current_LocationAndSpeedMetadata.ratio)
	$Train.position = path_follow.position

func _process(delta):
	var direction_multiplier = direction_to_speed_multiplier(current_LocationAndSpeedMetadata.moving_forward)
	current_LocationAndSpeedMetadata.ratio += direction_multiplier * speed * delta
	if current_LocationAndSpeedMetadata.ratio > 1:
		var frontier_side: int = get_cell_exit_side(current_LocationAndSpeedMetadata.cell_coords)
		current_LocationAndSpeedMetadata = compute_next_locationAndSpeedMetadata(frontier_side, current_LocationAndSpeedMetadata.ratio-1)
	elif current_LocationAndSpeedMetadata.ratio < 0:
		var frontier_side: int = get_cell_entry_side(current_LocationAndSpeedMetadata.cell_coords)
		current_LocationAndSpeedMetadata = compute_next_locationAndSpeedMetadata(frontier_side, -current_LocationAndSpeedMetadata.ratio)
	set_train_position()

func compute_next_locationAndSpeedMetadata(frontier_side: int, remaining_ratio:float) -> LocationAndSpeedMetadata:
	assert(0 < remaining_ratio and remaining_ratio < 1)
	var next_cell_coords: Vector2i = get_neighbor_cell(current_LocationAndSpeedMetadata.cell_coords, side_to_CellNeighbor(frontier_side))

	if get_cell_tile_data(0, next_cell_coords) == null:
		return get_locationAndSpeedMetadata_with_reverse_direction()

	var move_forward_on_next_path: bool = next_cell_entry_side(frontier_side) == get_cell_entry_side(next_cell_coords)
	var res = LocationAndSpeedMetadata.new(next_cell_coords, move_forward_on_next_path)
	if move_forward_on_next_path:
		res.ratio = remaining_ratio
	else:
		res.ratio = 1 - remaining_ratio
	return res

func get_locationAndSpeedMetadata_with_reverse_direction() -> LocationAndSpeedMetadata:
	var res = LocationAndSpeedMetadata.new(current_LocationAndSpeedMetadata.cell_coords, not current_LocationAndSpeedMetadata.moving_forward)
	res.ratio = clamp(current_LocationAndSpeedMetadata.ratio, 0, 1)
	return res

class LocationAndSpeedMetadata:
	var cell_coords: Vector2i
	var moving_forward: bool
	var ratio: float

	func _init(cell_coords_p: Vector2i, moving_forward_p: bool):
		cell_coords = cell_coords_p
		moving_forward = moving_forward_p

	func _to_string() -> String:
		return "[coords: " + str(cell_coords) + ", forward: " + str(moving_forward) + ", ratio: " + str(ratio) + "]"

func direction_to_speed_multiplier(move_forward: bool) -> int:
	return 1 if move_forward else -1

func side_to_CellNeighbor(side: int) -> TileSet.CellNeighbor:
	match side:
		RIGHT:
			return TileSet.CELL_NEIGHBOR_RIGHT_SIDE
		UP:
			return TileSet.CELL_NEIGHBOR_TOP_SIDE
		LEFT:
			return TileSet.CELL_NEIGHBOR_LEFT_SIDE
		DOWN:
			return TileSet.CELL_NEIGHBOR_BOTTOM_SIDE
		_:
			push_error("unexpected side: " + str(side))
			return 0 as TileSet.CellNeighbor

func next_cell_entry_side(current_cell_exit_side: int) -> int:
	match current_cell_exit_side:
		RIGHT:
			return LEFT
		UP:
			return DOWN
		LEFT:
			return RIGHT
		DOWN:
			return UP
		_:
			push_error("Unexpected exit: " + str(current_cell_exit_side))
			return 0 # placeholder because we need a value

func add_tile(coords: Vector2i, tile_id: int) -> void:
	# set cell
	var atlas_coords = Vector2i(tile_id, 0)
	set_cell(0, coords, tileset_source_id, atlas_coords)
	
	# create path
	var path = Path2D.new()
	var curve = Curve2D.new()
	var custom_data: Array = get_cell_custom_data(coords)
	var tile_size: Vector2i = get_tileset().get_tile_size()
	for exit in custom_data:
		curve.add_point(exit_to_point(exit) + Vector2(coords.x * tile_size.x, coords.y * tile_size.y))
	path.set_curve(curve)
	
	var pathFollow2D = PathFollow2D.new()
	pathFollow2D.set_name("PathFollow2D")
	path.add_child(pathFollow2D, true)
	add_child(path)
	
	#register the path
	cell_to_path[coords] = path

func get_cell_entry_side(cell_coords: Vector2i) -> int:
	return get_cell_custom_data(cell_coords)[0]

func get_cell_exit_side(cell_coords: Vector2i) -> int:
	return get_cell_custom_data(cell_coords)[1]

func get_cell_custom_data(cell_coords: Vector2i) -> Array:
	return get_cell_tile_data(0, cell_coords).get_custom_data("exits")


func exit_to_point(exit: int) -> Vector2:
	var tile_size: Vector2i = get_tileset().get_tile_size()
	match exit:
		RIGHT:
			return Vector2(tile_size.x, tile_size.y/2.0)
		UP: 
			return Vector2(tile_size.x/2.0, 0)
		LEFT:
			return Vector2(0, tile_size.y/2.0)
		DOWN:
			return Vector2(tile_size.x/2.0, tile_size.y)
		_:
			push_error("Unexpected exit: " + str(exit))
			return Vector2.ZERO

