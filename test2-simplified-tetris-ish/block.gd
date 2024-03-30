extends Area2D

signal overlap

var size = 20 # must match the size of the collision box and the sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_position_of_upper_side():
	return position.y - size / 2

func get_position_of_lower_side():
	return position.y + size / 2

func set_position_of_lower_side(y):
	position.y = y - size / 2
func _on_area_entered(area):
	overlap.emit(self)
