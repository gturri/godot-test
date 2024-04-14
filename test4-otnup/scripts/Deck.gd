class_name Deck

var remaining: Array[int] = []

func _init():
	for number in 9:
		remaining.append(number)
		remaining.append(number)
	remaining.shuffle()

func draw() -> int:
	return remaining.pop_back()

func isEmpty() -> bool:
	return remaining.is_empty()
