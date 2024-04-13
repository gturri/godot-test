extends Node

var remaining = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	for number in 9:
		remaining.append(number)
		remaining.append(number)
	remaining.shuffle()
		
func draw() -> int:
	return remaining.pop_back()

func isEmpty() -> bool:
	return remaining.is_empty()
