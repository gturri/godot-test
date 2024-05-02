extends Node2D

@export var speed = 400
var currentBlock

func _ready():
	currentBlock = $BlockTarget

func _physics_process(_delta):
	currentBlock.velocity = speed * Input.get_vector("left", "right", "up", "down")
	currentBlock.move_and_slide()

func _on_goal_area_body_entered(_body):
	print("Player won") # TODO: re-emit to the HUD and stop game


func _on_block_is_selected(block):
	print("Selected a block")
	currentBlock = block
