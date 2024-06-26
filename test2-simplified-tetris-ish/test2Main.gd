extends Node2D

@export var block_scene: PackedScene

var current_block
var viewport_size
var vertical_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_size = get_viewport_rect().size
	new_current_block()

func new_current_block():
	if current_block:
		current_block.set_physics_process (false)
	current_block = block_scene.instantiate()
	current_block.position.x = viewport_size.x / 2
	current_block.position.y = 0
	current_block.vertical_speed = vertical_speed
	add_child(current_block)

	current_block.hit_bottom.connect(on_current_block_reached_bottom)

func on_current_block_reached_bottom():
	new_current_block()
