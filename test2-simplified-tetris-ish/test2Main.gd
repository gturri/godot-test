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
	current_block = block_scene.instantiate()
	current_block.position.x = viewport_size.x / 2
	current_block.position.y = 0
	add_child(current_block)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_block.position.y += vertical_speed*delta
	if current_block.position.y > viewport_size.y:
		current_block.position.y = viewport_size.y
		new_current_block()
