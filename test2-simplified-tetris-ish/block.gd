extends CharacterBody2D

signal hit_bottom

var vertical_speed # need to be injected
var is_just_created = true
var reached_bottom_already = false

func _physics_process(delta):
	if reached_bottom_already:
		return
	if not is_just_created and get_last_motion().length() == 0:
		reached_bottom_already = true
		hit_bottom.emit()
		return
	is_just_created = false
	velocity = vertical_speed * Vector2.DOWN
	move_and_slide()

