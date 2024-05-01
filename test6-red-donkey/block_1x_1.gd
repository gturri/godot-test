extends CharacterBody2D

signal is_selected(selfBlock: CharacterBody2D)

func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("click"):
		is_selected.emit(self)
