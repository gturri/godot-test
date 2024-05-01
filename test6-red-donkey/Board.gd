extends Node2D

@export var speed = 100
var currentBlock

func _ready():
	currentBlock = $BlockTarget

func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1

	currentBlock.velocity = speed * direction
	currentBlock.move_and_slide()

func _on_goal_area_body_entered(body):
	print("Player won") # TODO: re-emit to the HUD and stop game
