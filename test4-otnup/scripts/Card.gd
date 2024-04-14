class_name Card

var player:int
var cardValue: int

func _init(playerId, card_value):
	self.player = playerId
	self.cardValue = card_value

func _to_string():
	return "player: " + str(player) + ", value: " + str(cardValue)
