extends Node2D

var decks: Array[Deck] = []
var currentPlayer: int = 0
var numberPlayers: int = 2

var nextCard: Card

var isGameCompleted: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for player in range(numberPlayers): decks.append(Deck.new(player))
	__drawNextCard()

func _input(event):
	if isGameCompleted:
		return
	if event.is_action_pressed("select_tile"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos: Vector2i = $BoardView.clickPosToCardPos(mouse_pos)
		if not $BoardModel.canPutCard(tile_pos, nextCard):
			return
		$BoardView.putCard(tile_pos, nextCard)
		$BoardModel.putCard(tile_pos, nextCard)

		if $BoardModel.hasJustWon(tile_pos):
			print("Player just won")
			isGameCompleted = true
			# TODO: send a signal
		elif __areDecksEmpty():
			print("No cards left for anyone")
			isGameCompleted = true
			# TODO: send a signal
		else:
			currentPlayer = (currentPlayer + 1) % numberPlayers
			__drawNextCard()

func __drawNextCard():
	nextCard = decks[currentPlayer].draw()
	# TODO: display this message in-game
	print("next card (for player " + str(currentPlayer) + "): " + str(nextCard))

func __areDecksEmpty():
	for deck in decks:
		if not deck.isEmpty():
			return false
	return true
