extends Node2D

signal hit

@export var characterScene: PackedScene

var character1
var character2
var cameraSpeed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	character1 = buildCharacter(0.1, 0, Color(0, 0, 1))
	add_child(character1)
	character2 = buildCharacter(-0.1, 0.5, Color(0, 1, 0))
	add_child(character2)

func buildCharacter(speed, ratio, color):
	var character = characterScene.instantiate()
	character.modulate = color
	character.speed = speed
	character.ratio = ratio
	return character

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processCharacter(character1, delta)
	processCharacter(character2, delta)

	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.y -= 1
	if Input.is_action_pressed("ui_right"):
		direction.y += 1
	direction = direction.normalized() * delta * cameraSpeed

	$Camera2D.position += direction

func processCharacter(character, delta):
	character.ratio += character.speed * delta
	$Path2D/PathFollow2D.progress_ratio = character.ratio
	character.position = $Path2D/PathFollow2D.position
