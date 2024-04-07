extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#print("tempGT: got click event")
		var mouse_pos = get_global_mouse_position()
		var tile_pos = $TileMap.local_to_map(mouse_pos)
		print("tempGT: " + str(mouse_pos) + " --> " + str(tile_pos))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
