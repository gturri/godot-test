extends Camera2D

var moveCamera: bool = false
var previousPosition: Vector2

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			moveCamera = true
			previousPosition = event.position
		else:
			moveCamera = false
	elif event is InputEventMouseMotion && moveCamera:
		# get_tree().set_input_as_handled(); # TODO: understand if we need this line (which comes from the snippet on https://forum.godotengine.org/t/how-to-drag-camera-with-mouse/28508/2 )
		position += (previousPosition - event.position)
		previousPosition = event.position
