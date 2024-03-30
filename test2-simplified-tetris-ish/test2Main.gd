extends Node2D

@export var block_scene: PackedScene

var current_block
var current_block_at_beginning_of_current_frame
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

	current_block.overlap.connect(on_current_block_reached_bottom)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_block_at_beginning_of_current_frame = current_block
	current_block.position.y += vertical_speed*delta
	if current_block.get_position_of_lower_side() > viewport_size.y:
		current_block.set_position_of_lower_side(viewport_size.y)
		new_current_block()

func on_current_block_reached_bottom(emitter_block):
	# we will receive the signal twice (because the collision involves two blocks)
	# but we should just handle it once.
	# handling when it's emitted by an old block makes it more convenient to retrieve
	# the position of its top

	# nb: we don't test against "current_block" in case it was already re-assigned by the event sent
	# by the other block (it would hence lead to handling the event twice)
	if emitter_block == current_block_at_beginning_of_current_frame:
		return
	current_block.set_position_of_lower_side(emitter_block.get_position_of_upper_side())
	new_current_block()
