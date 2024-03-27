extends Node2D

@export var characterScene: PackedScene

var character1
var ratioCharacter1 = 0
var speed1 = 0.1

var character2
var ratioCharacter2 = 0.5
var speed2 = -0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	character1 = buildCharacter(Color(0, 0, 1))
	add_child(character1)
	character2 = buildCharacter(Color(0, 1, 0))
	add_child(character2)

func buildCharacter(color):
	var character = characterScene.instantiate()
	character.modulate = color
	return character

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ratioCharacter1 += speed1 * delta
	$Path2D/PathFollow2D.progress_ratio = ratioCharacter1
	character1.position = $Path2D/PathFollow2D.position

	ratioCharacter2 += speed2 * delta
	$Path2D/PathFollow2D.progress_ratio = ratioCharacter2
	character2.position = $Path2D/PathFollow2D.position

