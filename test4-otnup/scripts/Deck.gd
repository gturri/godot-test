class_name Deck

var remaining: Array[Card] = []

func _init(player:int, nbValues:int=9, nbOccurenceOfEach:int=2):
	for value in nbValues:
		for i in nbOccurenceOfEach:
			remaining.append(Card.new(player, value))
	remaining.shuffle()

func draw() -> Card:
	return remaining.pop_back()

func isEmpty() -> bool:
	return remaining.is_empty()
