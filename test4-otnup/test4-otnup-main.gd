extends Node2D

var deckScene = preload("res://test4-otnup/Deck.tscn")
var decks = Array()
var currentPlayer = 0
var numberPlayers = 2

var nextCard

var isGameCompleted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	createDeck()
	createDeck()
	drawNextCard()

func createDeck():
	var deck = deckScene.instantiate()
	add_child(deck)
	decks.append(deck)

func _input(event):
	if isGameCompleted:
		return
	if event.is_action_pressed("select_tile"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos: Vector2i = $BoardView.local_to_map(mouse_pos)
		if not $BoardModel.canPutCard(tile_pos, nextCard, currentPlayer):
			return
		var tile = Vector2i(nextCard, currentPlayer)
		$BoardView.set_cell(0, tile_pos, 1, tile)
		$BoardModel.putCard(tile_pos, nextCard, currentPlayer)

		if $BoardModel.hasJustWon(tile_pos, currentPlayer):
			print("Player just won")
			isGameCompleted = true
			# TODO: send signal
		# TODO: check if there are no cards left

		currentPlayer = (currentPlayer + 1) % numberPlayers
		drawNextCard()

func drawNextCard():
	nextCard = decks[currentPlayer].draw()
	# TODO: display this message in-game
	print("next card (for player " + str(currentPlayer) + "): " + str(nextCard))

