extends Node

var remaining = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	for number in 9:
		remaining.append(number)
		remaining.append(number)
	remaining.shuffle()
		
func draw():
	return remaining.pop_back()


