extends Node2D

@export var speed = 400
var currentBlock

func _ready():
	currentBlock = $BlockTarget

func _physics_process(_delta):
	# get input from keyboard
	var direction = Input.get_vector("left", "right", "up", "down")

	# if no key was pressed but the mouse is clicked, get input from mouse
	if not direction.length() and Input.is_action_pressed("click"):
		direction = get_global_mouse_position() - currentBlock.position

		# normalize only if the vector is big, to try to avoid oscillations around the cursor
		# (though it's not enough, there can still be some oscillations)
		if direction.length() > 1:
			direction = direction.normalized()

	currentBlock.velocity = speed * direction
	currentBlock.move_and_slide()

func _on_goal_area_body_entered(_body):
	print("Player won") # TODO: re-emit to the HUD and stop game


func _on_block_is_selected(block):
	print("Selected a block")
	currentBlock = block
