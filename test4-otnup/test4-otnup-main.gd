extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("select_tile"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos = $TileMap.local_to_map(mouse_pos)
		print("tempGT: " + str(mouse_pos) + " --> " + str(tile_pos))
		$TileMap.set_cell(0, tile_pos, 0, Vector2i(1, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
